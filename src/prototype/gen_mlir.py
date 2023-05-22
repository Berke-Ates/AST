# @file
# @brief Prototype python program to generate MLIR code
# Usage: python3 gen_mlir.py
# Add description

from typing import List
import random
import  sys

sys.setrecursionlimit(10**6)

# Global variables
nl = '\n'

class Type():

    def __init__(self, name: str):
        self.name = name

    def __eq__(self, __value: object) -> bool:
        if isinstance(__value, Type):
            return self.name == __value.name
        return False

# If the rank is unknown, leave the dimension list empty
# If the dimension is dynamic, use '-1' in the dimension list
# The unranked dimension list specifies the unranked dimensions after allocations (from left to right)
class TypeMemref(Type):
    def __init__(self, dimension_list: List[int], type: Type):
        self.type = type
        self.dimension_list = dimension_list

        # Case for unknown rank
        if (len(dimension_list) == 0):
            return f"memref<*x{type.name}>"

        str_dim = 'x'.join(f'{"?" if i == -1 else i}' for i in dimension_list)

        self.name = f"memref<{str_dim}x{type.name}>"

    def __eq__(self, __value: object) -> bool:
        if isinstance(__value, Type):
            return self.name == __value.name
        return False

class Module():
    def generate(mlir_obj, env: List):
        return Module.emit(Function.generate(mlir_obj, env))

    def emit(statements: str):
        return f"module {{ {nl} {statements} {nl} }}"

class Expression():
    def generate(mlir_obj, env: List):
        pass
    
    def emit(primitive: str, args, return_type):
        args = ', '.join(f"{i if isinstance(i, (int, float)) else '%'+i.name}" for i in args)
        return f"{primitive} {args} : {', '.join(f'{r.name}' for r in return_type)}"

class Variable():

    def __init__(self, name: str, v_type: Type):
        self.name = name
        self.type = v_type

    def generate(mlir_obj, env: List):
        name = "var" + str(mlir_obj.global_scope_ctr)
        type = Type(random.choice(mlir_obj.typenames))

        if type.name == "f32" or type.name == "f64":
            val = random.uniform(0, 1)
        elif type.name == "i1":
            val = random.randint(0, 1)
        else:
            val = random.randint(-10, 10)

        const1 = Expression.emit("arith.constant", [val], [type])
        v2 = Variable(name, type)

        env.append(v2)
        mlir_obj.global_scope_ctr += 1

        return Variable.emit([v2], const1)


    def emit(assign_vars: List, expr: str):
        if(len(assign_vars) == 0):
            return expr
        
        return f"{', '.join([f'%{i.name}' for i in assign_vars])} = {expr}\n"
    
# If the rank is unknown, leave the dimension list empty
# If the dimension is dynamic, use '-1' in the dimension list
# The unranked dimension list specifies the unranked dimensions after allocations (from left to right)
class MemrefVariable():

    def __init__(self, name: str, v_type: Type, dimension_list: List[int], unranked_dimension_list: List):
        self.name = name
        self.type = v_type
        self.dimension_list = dimension_list
        self.unranked_dimension_list = unranked_dimension_list

    def generate(mlir_obj, env: List):
        # Generation proceeds as follows
        # 1. Choose type
        # 2. Choose dimensions
        # 3. Create argument list
        # 4. Create memref variable object
        # 5. Add variable object to environments
        # 6. Choose either alloc() or alloca()
        # 7. Emit

        # Type
        type = Type(random.choice(mlir_obj.typenames))

        # Dimensions
        dimension_list = []

        # Remember: Dimension list left empty will generate an unranked memref
        # Emulating do-while loop here to ensure at least one dimension is added
        dimension_list.append(mlir_obj.dimension_finder())
        while random.random() < 0.4:
            dimension_list.append(mlir_obj.dimension_finder())

        # Argument list
        # Find number of dynamic dimension
        dyn_count = len([elem for elem in dimension_list if elem == -1]) 
        arg_list = []
        for _ in range(dyn_count):
            arg_list.append(random.randint(1, 100))

        # Create variable object
        memref_type = TypeMemref(dimension_list, type)
        name = "var" + str(mlir_obj.global_scope_ctr)
        memref_variable = MemrefVariable(name, memref_type, dimension_list, arg_list)

        env.append(memref_variable)
        mlir_obj.global_scope_ctr += 1
        
        alloc_str = ""

        if random.random() < 0.7:
            alloc_str = MemrefAlloc.emit(memref_variable)
        else:
            alloc_str = MemrefAlloca.emit(memref_variable)

        return MemrefVariable.emit(name, alloc_str)

    # Since memref variables are bound to a memref allocating operation, pass
    def emit(var_name: str, alloc_str):
        return f"%{var_name} = {alloc_str}"

class Function():
    def generate(mlir_obj, env: List):

        # make a copy of env
        local_env = env.copy()

        # Randomly create return types
        return_type = []
        while random.random() < 0.5:
            return_type.append(Type(random.choice(mlir_obj.typenames)))

        mlir_obj.call_stack.append(("Function", "Main"))

        statements = mlir_obj.generate_region(local_env, return_type)

        mlir_obj.call_stack = mlir_obj.call_stack[:-1]

        return Function.emit("main", [], return_type, statements)

    def emit(name: str, params, return_type, statements: str):
        return f"func.func @{name} ({', '.join([f'%{p.name} : {p.type.name}' for p in params])}) -> ({', '.join(f'{r.name}' for r in return_type)}) {{ {nl}" + \
            statements + \
            f" {nl} }}"

class ForLoop():
    # SSA loop vars are initialized in order:
    # ssa_vars[0]: iteration var
    # ssa_vars[1]: lower bound var
    # ssa_vars[2]: upper bound var
    # ssa_vars[3]: step var

    def generate(mlir_obj, env: List[Variable]):

        # output string
        output = ""


        # Generate random return type
        for_return_type = []
        while random.random() < 0.5:
            for_return_type.append(Type(random.choice(mlir_obj.typenames)))

        # ====== Generate | Pick loop variables (must be SSA) ====== 
        ssa_vars = []
        index_case = True

        # Pick index or signless integer case
        if random.random() < 0.5:
            index_case = False

        # Pick index variables (Leave out i1 as it doesn't make sense)
        type_name = ""
        if index_case:
            type_name = "index"
        else:
            p = random.random()
            if p < 0.33:
                type_name = "i8"
            elif p < 0.66:
                type_name = "i32"
            else:
                type_name = "i64"

        existing_vars = [var for var in env if var.type.name == type_name]

        # while we still have elements in existing_vars and we haven't populated ssa_vars, add some existing variable
        while(len(existing_vars) > 0 and len(ssa_vars) < 3):
            if random.random() < 0.5:
                choice = random.choice(existing_vars)
                ssa_vars.append(choice)
                existing_vars.remove(choice)
        
        # while we haven't populated ssa_vars, create variables
        while(len(ssa_vars) < 3):
            name = "var" + str(mlir_obj.global_scope_ctr)
            type = Type(type_name)
            val = random.randint(-10, 10)
            const_ssa = Expression.emit("arith.constant", [val], [type])
            ssa = Variable(name, type)

            mlir_obj.global_scope_ctr += 1
            output += Variable.emit([ssa], const_ssa)
            ssa_vars.append(ssa)
                
        # Since step must be positive, we will instead generate a positive variable with 100% certainty
        # TODO: extend in the future
        name = "var" + str(mlir_obj.global_scope_ctr)
        type = Type(type_name)
        val = random.randint(1, 10) # only positive ranges
        const_step = Expression.emit("arith.constant", [val], [type])
        step = Variable(name, type)

        mlir_obj.global_scope_ctr += 1
        output += Variable.emit([step], const_step)
        ssa_vars.append(step)

        # ====== Generate | Pick iteration arguments ====== 
        iter_args = []

        # Choose random environment variable and assign it to newly generated variable
        while random.random() < 0.25:
            if(len(env) > 0):
                choice = random.choice(env)

                name = "var" + str(mlir_obj.global_scope_ctr)
                type = Type(choice.type.name)
                v = Variable(name, type)
                mlir_obj.global_scope_ctr += 1

                iter_args.append((v, choice))

        # ======  Add generated variables to environment ====== 
        for elem in ssa_vars:
            env.append(elem)

        # Finally, copy environment
        local_env = env.copy()

        # Add iter_arg to the local environment\
        for (left, _) in iter_args:
            local_env.append(left)

        # ======  Append 'For' to the call sequence ====== 
        mlir_obj.call_stack.append(("ForLoop", "?"))

        statements = mlir_obj.generate_region(local_env, for_return_type)

        for_str = ForLoop.emit(ssa_vars, index_case, iter_args, for_return_type, statements)
        
        # Delete Forloop call
        mlir_obj.call_stack = mlir_obj.call_stack[:-1]

        assign_vars = mlir_obj.find_assignment_vars(env, for_return_type)

        return output + Variable.emit(assign_vars, for_str)


    def emit(ssa_vars: List[Variable], index_case: bool, iter_args: 'List[tuple[Variable, Variable]]', return_type: List[Type], statements: str):
        iv = ssa_vars[0].name
        lb = ssa_vars[1].name
        ub = ssa_vars[2].name
        step = ssa_vars[3].name

        # Include iteration type if not index case
        it_type = ""
        if (not index_case):
            it_type = f": {ssa_vars[0].type.name}"

        return f"scf.for %{iv} = %{lb} to %{ub} step %{step} " + it_type + f"{nl}" + \
            f"iter_args({', '.join(f'%{l.name} = %{r.name}' for (l,r) in iter_args)}) ->  ({', '.join(f'{r.name}' for r in return_type)}) {{ {nl}" + \
            f"{statements} {nl} }} {nl}"

class If():
    def generate(mlir_obj, env: List[Variable]):
        
        # make a copy of env
        local_env = env.copy() 

        # output string
        output = ""

        if_return_type = []

        while random.random() < 0.5:
            if_return_type.append(Type(random.choice(mlir_obj.typenames)))

        # Generate | Pick condition variable
        p = random.random()
        potential_cond_vars = [var for var in env if var.type.name == "i1"] # Get variables with type "i1"

        name = "var" + str(mlir_obj.global_scope_ctr)
        type = Type("i1")
        val = random.randint(0, 1)
        const1 = Expression.emit("arith.constant", [val], [type])
        v2 = Variable(name, type)
        condition_var = v2 

        # If there exists potential ones, choose one with p=0.5 
        if(len(potential_cond_vars) > 0 and p < 0.5):
                condition_var = random.choice(potential_cond_vars)
        else:
            output += Variable.emit([v2], const1)
            env.append(v2)
            local_env.append(v2)
            mlir_obj.global_scope_ctr += 1
        
        # Append 'If' to the call sequence
        mlir_obj.call_stack.append(("If", "?"))

        statements_then = mlir_obj.generate_region(local_env, if_return_type)
        statements_else = mlir_obj.generate_region(local_env, if_return_type)

        if_str = If.emit(condition_var, if_return_type, statements_then, statements_else)

        # Delete If call
        mlir_obj.call_stack = mlir_obj.call_stack[:-1]

        if(len(if_return_type) == 0):
            return output+if_str
        else:
            assign_vars = []
            
            for type in if_return_type:
                # Generate list of all available types in env
                possible_vars = [var for var in env if var.type == type]

                # if there are no variables, create one and add it to env
                if(len(possible_vars) == 0):
                    name = "var" + str(mlir_obj.global_scope_ctr)
                    v = Variable(name, type)
                    possible_vars.append(v)
                    env.append(v)
                    local_env.append(v)
                    mlir_obj.global_scope_ctr += 1

                choice = random.choice(possible_vars)
                assign_vars.append(choice)

            return output + Variable.emit(assign_vars, if_str)
            
        

        

    def emit(condition_var: Variable, return_type: List[Type], statements_then: str, statements_else: str):
        cond = condition_var.name
        else_output = ""
        first_line = f"scf.if %{cond} -> ({', '.join(f'{r.name}' for r in return_type)}) {{ {nl}"

        # Check if return type is empty, and adjust first line
        if (len(return_type) == 0):
            first_line = f"scf.if %{cond} {{ {nl}"

        # Check if else case is populated
        if (len(statements_else) != 0):
            else_output = f" else {{ {nl}" + \
            statements_else + \
                f"{nl} }}"

        return first_line + \
                statements_then + \
                f"{nl} }} {nl}" + \
                else_output + f"{nl}"

class Condition():
    def emit(condition_var: Variable, return_obj: List[Variable]):

        if(len(return_obj) > 0):
            return f"scf.condition(%{condition_var.name}) {', '.join(f'{r.name}' for r in return_obj)} : {', '.join(f'{r.type.name}' for r in return_obj)}"
        
        return f"scf.condition(%{condition_var.name})" 

class WhileDo():

    def generate(mlir_obj, env: List):
        # Copy environment
        local_env = env.copy()

        # output string
        output = ""

        # Generate random return type
        while_return_type = []
        while random.random() < 0.5:
            while_return_type.append(Type(random.choice(mlir_obj.typenames)))

        # Pick RHS argument list assignment variables and create corresponding, new LHS assignment list variables
        assignment_list = []
        while random.random() < 0.5:
            if(len(env) > 0):
                choice = random.choice(env)

                name = "var" + str(mlir_obj.global_scope_ctr)
                type = Type(choice.type.name)
                v = Variable(name, type)
                mlir_obj.global_scope_ctr += 1
                local_env.append(v)

                assignment_list.append((v, choice))

        # ========== Generate before region ==========
        # Append 'WhileDo' to the call sequence: Distinguish before and after region for the condition/yield statement
        mlir_obj.call_stack.append(("WhileDo", "Before"))

        # scf.condition is handled in generate_region
        statements_before = mlir_obj.generate_region(local_env, while_return_type)
        
        # Delete 'WhileDo' before region call
        mlir_obj.call_stack = mlir_obj.call_stack[:-1]

        # Create new variables for the after region arguments
        # Have to be added to local env
        after_region_arguments = []

        for type in while_return_type:
            name = "var" + str(mlir_obj.global_scope_ctr)
            v = Variable(name, type)
            mlir_obj.global_scope_ctr += 1
            local_env.append(v)
            after_region_arguments.append(v)

        # ========== Generate after region ==========
        # Append 'WhileDo' to the call sequence: Distinguish before and after region for the condition/yield statement
        mlir_obj.call_stack.append(("WhileDo", "After"))

        # scf.yield is handled in generate_region
        statements_after = mlir_obj.generate_region(local_env, while_return_type)
        
        # Delete 'WhileDo' before region call
        mlir_obj.call_stack = mlir_obj.call_stack[:-1]

        while_str = WhileDo.emit(assignment_list, statements_before, statements_after, after_region_arguments, while_return_type)

        assign_vars = mlir_obj.find_assignment_vars(env, while_return_type)

        return Variable.emit(assign_vars, while_str)

    def emit(assignment_list: 'List[tuple[Variable, Variable]]', statements_before: str, statements_after: str, after_region_arguments: List[Variable], return_type: List[Type]):
        assignment_list_str = ""
        if(len(assignment_list) > 0):
            assignment_list_str = f"({', '.join(f'%{l.name} = %{r.name}' for (l,r) in assignment_list)})"

        func_type_str = f": ({', '.join(f'{l.type.name}' for (l,r) in assignment_list)}) -> ({', '.join(f'{r.name}' for r in return_type)})"
        after_arguments_str = f"^bb0({', '.join(f'%{v.name} : {v.type.name}' for v in after_region_arguments)}): {nl}"

        return "scf.while " + assignment_list_str + func_type_str + f"{{ {nl}" + \
                statements_before+ \
                 f"{nl} }} do {{ {nl}" + \
                 after_arguments_str + \
                statements_after + \
                f"{nl} }}"

class MemrefLoad(Expression):
    def generate(mlir_obj, env: List):
        # Generation
        # 1. Find/Generate memref variable
        # 2. Find/Generate indices
        # 3. Assign variable and add it to environment

        output = ""
        # Generate/Choose memref variable
        potential_memref_vars = [var for var in env if isinstance(var, MemrefVariable)] # Get potential variables with memref type
        if random.random() < 0.75 and len(potential_memref_vars) > 0:
            memref_var = random.choice(potential_memref_vars)
        else:
            output += MemrefVariable.generate(mlir_obj, env)
            memref_var = env[-1]

        # Find/Generate indices
        count_idx = len(memref_var.dimension_list)
        potential_indices_vars = [var for var in env if var.type.name == "index"]
        indices_list = []
        while(len(indices_list) != count_idx):
            if random.random() > 0.75 and len(potential_indices_vars) > 0:
                indices_list.append(random.choice(potential_indices_vars))
            else:
                indices_list.append(random.randint(0,100))

        # Create variable and add it to environment
        name = "var" + str(mlir_obj.global_scope_ctr)
        type = memref_var.type
        var = Variable(name, type)

        env.append(var)
        mlir_obj.global_scope_ctr += 1

        memref_load_str = MemrefLoad.emit(memref_var, indices_list)
        output += Variable.emit([var], memref_load_str)
        return output

    def emit(memref_var: MemrefVariable, indices_list: List):
        memref = memref_var.name
        indices = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in indices_list)

        return f"memref.load %{memref}[{indices}] : {memref_var.type.name}"


class MemrefStore(Expression):
    def generate(mlir_obj, env: List):
        # Generation
        # 1. Either generate or choose a memref variable
        # 2. Find or generate value
        # 3. Find or generate indices
        # 4. Emit

        output = ""
        # Generate/Choose memref variable
        potential_memref_vars = [var for var in env if isinstance(var.type, TypeMemref)] # Get potential variables with memref type

        if random.random() > 0.75 and len(potential_memref_vars) > 0:
            memref_var = random.choice(potential_memref_vars)
        else:
            output += MemrefVariable.generate(mlir_obj, env)
            memref_var = env[-1]

        # Find/Generate value
        potential_value_vars = [var for var in env if var.type == memref_var.type]

        if random.random() > 0.75 and len(potential_value_vars) > 0:
            value_var = random.choice(potential_value_vars)
        else:
            type = memref_var.type
            if type.name == "f32" or type.name == "f64":
                value_var = random.uniform(0, 1)
            elif type.name == "i1":
                value_var = random.randint(0, 1)
            else:
                value_var = random.randint(-10, 10)

        # Find/Generate indices
        count_idx = len(memref_var.dimension_list)
        potential_indices_vars = [var for var in env if var.type.name == "index"]
        indices_list = []
        while(len(indices_list) != count_idx):
            if random.random() > 0.75 and len(potential_indices_vars) > 0:
                indices_list.append(random.choice(potential_indices_vars))
            else:
                indices_list.append(random.randint(0,100))

        output += MemrefStore.emit(value_var, memref_var, indices_list)
        return output
        

    def emit(value_var: Variable, memref_var: MemrefVariable, indices_list: List):
        memref = memref_var.name
        indices = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in indices_list)

        return f"memref.store {value_var if isinstance(value_var, int) else '%'+value_var.name}, %{memref}[{indices}] : {memref_var.type.name} {nl}"


class MemrefAlloc(Expression):
    # Allocation is handled from MemrefVariable
    def generate(mlir_obj, env: List):
        pass

    def emit(mem_var: MemrefVariable):
        arg_list = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in mem_var.unranked_dimension_list)
        return f"memref.alloc({arg_list}) : {mem_var.type.name} {nl}"


class MemrefAlloca(Expression):
    # Allocation is handled from MemrefVariable
    def generate(mlir_obj, env: List):
        pass

    def emit(mem_var: MemrefVariable):
        arg_list = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in mem_var.unranked_dimension_list)
        return f"memref.alloca({arg_list}) : {mem_var.type.name} {nl}"


class MemrefCast(Expression):
    def generate(mlir_obj, env: List):
        # 1. Pick / Generate source variable
        # 2. Create new memref type that matches shape  
        # 4. Emit

        output = ""
        # Pick/Generate memref variable
        potential_memref_vars = [var for var in env if isinstance(var.type, TypeMemref)] # Get potential variables with memref type

        if len(potential_memref_vars) > 0:
            source_var = random.choice(potential_memref_vars)
        else:
            output += MemrefVariable.generate(mlir_obj, env)
            source_var = env[-1]

        # Note: In MLIR, when you cast a MemRef type from one to another, 
        # the source variable is still accessible and can be used. 
        # Casting a MemRef type in MLIR does not invalidate or make the source variable unreachable.
        
        # Create new memref type
        # .shape_cast() handles all details
        dimension_list, unranked_dimension_list = mlir_obj.shape_cast(source_var.dimension_list, source_var.unranked_dimension_list)

        dest_memref_type = TypeMemref(dimension_list, source_var.type.type)
        name = "var" + str(mlir_obj.global_scope_ctr)
        dest_memref_var = MemrefVariable(name, dest_memref_type, dimension_list, unranked_dimension_list)

        env.append(dest_memref_var)
        mlir_obj.global_scope_ctr += 1

        # Emit
        cast_str = MemrefCast.emit(source_var, source_var.type, dest_memref_type)

        output += MemrefVariable.emit(name, cast_str)
        return output

    def emit(source: MemrefVariable, from_type: TypeMemref, to_type: TypeMemref):
        return f"memref.cast %{source.name} : {from_type.name} to {to_type.name} {nl}"

class MemrefDealloc(Expression):
    def generate(mlir_obj, env: List):
        # 1. Pick / Generate memref variable
        # 2. Remove from environment
        # 3. Emit
        
        output = ""
        # Pick/Generate memref variable
        potential_memref_vars = [var for var in env if isinstance(var.type, TypeMemref)] # Get potential variables with memref type

        if len(potential_memref_vars) > 0:
            memref_var = random.choice(potential_memref_vars)
        else:
            output += MemrefVariable.generate(mlir_obj, env)
            memref_var = env[-1]

        # Remove from environment
        del env[-1]

        # Emit
        output += MemrefDealloc.emit(memref_var)
        return output


    def emit(memref_var: MemrefVariable):
        return f"memref.dealloc %{memref_var.name} : {memref_var.type.name} {nl}"

class MLIRSmith():

    # Contains global variables in the module
    # Local variables are handled in their respective objects
    global_scope_ctr = 0

    # Define types for usage
    typenames = []

    int_typenames = ["i1", "i8", "i32", "i64", "index"]
    float_typenames = ["f32", "f64"]

    # Define available operations
    available_operations = {
        'i1': {},
        'i8': {},
        'i32': {},
        'i64': {},
        'f32': {},
        'f64': {},
        'index': {}
    }

    # The call stack elements are defined as (Primitive, Name)
    # The call sequence is from left to right
    # Examples: 
    # - ("Function", "Main")
    # - ("If" : "Any")
    call_stack = []

    # Imports available operations and inserts them into available_operations
    def __init__(self, operations_import_file: str):
        self.typenames = self.int_typenames + self.float_typenames
        self.initialize_operations(operations_import_file)

        print(self.available_operations["i1"])
        return
    
    def initialize_operations(self, operations_import_file: str):
        with open(operations_import_file, 'r') as file:
            for line in file:
                # Parse the instruction line to extract resulting_type; instruction_name; operands
                instruction_name, operands, result_types = MLIRSmith.parse_instruction_line(line)

                for type in result_types:
                    if (type == "int"):
                        for int_type in self.int_typenames:
                            # Match all int types and convert them to the specific type to be used
                            self.available_operations[int_type][instruction_name] = [[int_type if elem == "int" else elem for elem in result_types],
                                                                                        [int_type if elem == "int" else elem for elem in operands]]
                    elif (type == "float"):
                        for float_type in self.float_typenames:
                            # Match all float types and convert them to the specific type to be used
                            self.available_operations[float_type][instruction_name] = [[float_type if elem == "float" else elem for elem in result_types],
                                                                                        [float_type if elem == "float" else elem for elem in operands]]
                    else:
                        # FIX ME: If it is possible to mix int and float types then this implementation won't work because
                        # this implementation only considers the same types
                        if("int" in operands):
                            for int_type in self.int_typenames:
                                # Match all int types and convert them to the specific type to be used
                                self.available_operations[int_type][instruction_name] = [[int_type if elem == "int" else elem for elem in result_types],
                                                                                        [int_type if elem == "int" else elem for elem in operands]]
                        elif("float" in operands):
                            for float_type in self.float_typenames:
                                # Match all float types and convert them to the specific type to be used
                                self.available_operations[float_type][instruction_name] = [[float_type if elem == "float" else elem for elem in result_types],
                                                                                        [float_type if elem == "float" else elem for elem in operands]]
                        else:
                            self.available_operations[type][instruction_name] = [result_types, operands]



    def parse_instruction_line(line: str):
        line_parts = line.strip().split(';')
        # Extract the instruction name
        instruction_name = line_parts[1].strip()
        # Extract the resulting types
        result_types = [result_type.strip() for result_type in line_parts[0].split(',')]
        # Extract the operand types
        operand_types = [operand_type.strip() for operand_type in line_parts[2].split(',')]

        return instruction_name, operand_types, result_types


    def generate_region(self, env: List[Variable], return_type: List[Type]):
        # copy environment
        local_env = env.copy()

        # Output string
        output = ""

        while (True):
            p = random.randrange(90)

            # Define constant variable
            if p < 40:
                output += Variable.generate(self, local_env)

            # Define memory alloc operation
            elif p < 90:
                output += MemrefCast.generate(self, local_env)

            elif p < 110:
                output += If.generate(self, local_env)

            elif p < 120:
                output += ForLoop.generate(self, local_env)

            elif p < 140:
                output += WhileDo.generate(self, local_env)

            # Check if we can generate a return Op
            available_return_types = [var.type for var in local_env]

            # If so randomly decide to generate one
            if all(elem in available_return_types for elem in return_type):
                if random.random() < 0.8:
                    return_obj = []
                    for type in return_type:
                        possible_vars = [var for var in local_env if var.type == type]
                        choice = random.choice(possible_vars)
                        return_obj.append(choice)

                    # Scf type return
                    if(((self.call_stack[-1])[0] == "If" or (self.call_stack[-1])[0] == "ForLoop" or ((self.call_stack[-1])[0] == "WhileDo" and (self.call_stack[-1])[1] == "After")) and len(return_type) > 0):
                        output += Expression.emit("scf.yield", return_obj, return_type)
                    elif((self.call_stack[-1])[0] == "Function"):
                        if(len(return_type) > 0):
                            output += Expression.emit("func.return", return_obj, return_type)
                        else:
                            output += f"func.return {nl}"
                    elif((self.call_stack[-1])[0] == "WhileDo" and (self.call_stack[-1])[1] == "Before"):
                        # Generate | Pick condition variable
                        p = random.random()
                        potential_cond_vars = [var for var in env if var.type.name == "i1"] # Get variables with type "i1"

                        name = "var" + str(self.global_scope_ctr)
                        type = Type("i1")
                        val = random.randint(0, 1)
                        const1 = Expression.emit("arith.constant", [val], [type])
                        condition_var = Variable(name, type)

                        # If there exists potential ones, choose one with p=0.5 
                        if(len(potential_cond_vars) > 0 and p < 0.5):
                            condition_var = random.choice(potential_cond_vars)
                        else:
                            output += Variable.emit([condition_var], const1)
                            local_env.append(condition_var)
                            self.global_scope_ctr += 1

                        output += Condition.emit(condition_var, return_obj)
                    
                    return output
                

    def generate_code(self):

        # =============== Defining modules ===============
        #Reinitialize global scope and environment
        self.global_scope_ctr = 0
        self.call_stack = []
        env = []

        generated_str = Module.generate(self, env)

        return generated_str
    
    # Finds a list of assignment variables given an environment and the requested return types.
    # If there is no variable with a type, a new one is added. The printing of the newly initialized variable is handled clientside.
    def find_assignment_vars(self, env: List, return_type):
        if(len(return_type) == 0):
            return []
        else:
            assign_vars = []
            
            for type in return_type:
                # Generate list of all available types in env
                possible_vars = [var for var in env if var.type == type]

                # if there are no variables, create one and add it to env
                if(len(possible_vars) == 0):
                    name = "var" + str(self.global_scope_ctr)
                    v = Variable(name, type)
                    possible_vars.append(v)
                    env.append(v)
                    self.global_scope_ctr += 1

                choice = random.choice(possible_vars)
                assign_vars.append(choice)

            return assign_vars
    
    # Returns either unknown dimension or some random dimension
    def dimension_finder(self):
        if random.random() < 0.6:
            return random.randint(1,100)
        return -1
    
    # Returns two new dimension lists that adhere to the memref.cast specification
    # Note: The source and destination types are compatible if
    # a. Both are ranked memref types with the same element type, address space, and rank and
    # the individual sizes may convert constant dimensions to dynamic dimensions and vice-versa.
    # b. Either or both memref types are unranked with the same element type, and address space.
    def shape_cast(self, source_dimension_list: List, source_unranked_dimension_list: List):
        # 1. Case: unranked type
        # 2. Case: ranked/dynamic type 
        # a. Find length
        # b. Find integers that divide and add them to the list of dimensions
        # The way we do is we create a product list first and then pick and choose dimensions
        # to be dynamic. The dynamic dimensions will then get the multiplier from the list
        # supplied to the unranked dimension list

        dimension_list = []
        unranked_dimension_list = []

        if(len(source_dimension_list) == 0):
            dimension_list.append(self.dimension_finder())
            while random.random() < 0.4:
                dimension_list.append(self.dimension_finder())

            for dim in dimension_list:
                if dim == -1:
                    unranked_dimension_list.append(random.randint(1,100))
        else:
            # Verify lengths
            if(len([dim for dim in source_dimension_list if dim == -1]) != len(source_unranked_dimension_list)):
                raise IndexError("Lengths of source dimension list of dynamic type and unranked dimension do not coincide.")
            
            length = 1
            idx = 0

            for dim in source_dimension_list:
                if dim == -1:
                    length *= source_unranked_dimension_list[idx]
                    idx+=1
                else:
                    length *= dim

            for _ in range(len(source_dimension_list) - 1):
                # Generate a random integer within a range that guarantees the product remains the same
                num = random.randint(1, length)
                dimension_list.append(num)
                length //= num

            # The last element in the list is the remaining product
            dimension_list.append(length)

            # Now choose elements to make dynamic and add to unranked_dimension_list
            for i in range(len(dimension_list)):
                if random.random() < 0.2:
                    val = dimension_list[i]
                    dimension_list[i] = -1
                    unranked_dimension_list.append(val)

        return dimension_list, unranked_dimension_list


def main():
    s = MLIRSmith("expression_import.txt")
    print(s.generate_code())


if __name__ == "__main__":
    main()
