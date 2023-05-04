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
class TypeMemref(Type):

    def __init__(self, dimension_list: List[int], type: Type):
        self.dimension_list = dimension_list
        self.type = type

        # Case for unknown rank
        if (len(dimension_list) == 0):
            return f"memref<*x{type.name}>"

        str_dim = 'x'.join(f'{"?" if i == -1 else i}' for i in dimension_list)

        self.name = f"memref<{str_dim}x{type.name}>"

    def parse_dict(self):
        return {"type": "typememref", "name": self.name, "dimension_list": self.dimension_list, "type": self.type}


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
        return f"{', '.join([f'%{i.name}' for i in assign_vars])} = {expr}\n"

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

        if(len(for_return_type) == 0):
            return output+for_str
        else:
            assign_vars = []
            
            for type in for_return_type:
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

    def __init__(self, condition_var: Variable, args: Variable):
        self.condition_var = condition_var
        self.args = args  # either zero or one argument

    def parse_dict(self):
        return {"type": "condition", "condition_var": self.condition_var, "args": self.args}


class WhileDo():

    def __init__(self, condition: Condition, assignment_list: 'List[tuple[Variable, Variable]]',
                 return_type: List[Variable]):
        self.condition = condition
        self.assignment_list = assignment_list
        self.return_type = return_type

        # Before and after regions
        self.statements_before = []
        self.statements_after = []
        self.local_scope_before = []
        self.local_scope_after = []

    def parse_dict(self):
        return {
            "type": "whiledo",
            "condition": self.condition,
            "assignment_list": self.assignment_list,
            "return_type": self.return_type,
            "statements_before": self.statements_before,
            "statements_after": self.statements_after
        }


class MemrefLoad(Expression):

    def __init__(self, memref: Variable, indices):
        self.memref = memref
        self.indices = indices  # list of constants and variables
        self.mem_type = type

    def parse_dict(self):
        return {"type": "memrefload", "memref": self.memref, "indices": self.indices}


class MemrefStore(Expression):

    def __init__(self, value: Variable, memref: Variable, indices):
        self.value = value
        self.memref = memref
        self.indices = indices  # list of constants and variables

    def parse_dict(self):
        return {"type": "memrefstore", "value": self.value, "memref": self.memref, "indices": self.indices}


class MemrefAlloc(Expression):

    def __init__(self, arg_list: List, type: TypeMemref):
        self.arg_list = arg_list
        self.mem_type = type

    def parse_dict(self):
        return {"type": "memrefalloc", "arg_list": self.arg_list, "mem_type": self.mem_type}


class MemrefAlloca(Expression):

    def __init__(self, arg_list: List, type: TypeMemref):
        self.arg_list = arg_list
        self.mem_type = type

    def parse_dict(self):
        return {"type": "memrefalloca", "arg_list": self.arg_list, "mem_type": self.mem_type}


class MemrefCast(Expression):

    def __init__(self, source: Variable, from_type: TypeMemref, to_type: TypeMemref):
        self.source = source
        self.from_type = from_type
        self.to_type = to_type

    def parse_dict(self):
        return {"type": "memrefcast", "source": self.source, "from_type": self.from_type, "to_type": self.to_type}

class MLIRSmith():

    # Contains global variables in the module
    # Local variables are handled in their respective objects
    global_scope_ctr = 0

    # Define types for usage
    typenames = ["i1", "i8", "i32", "i64", "f32", "f64", "index"]

    # The call stack elements are defined as (Primitive, Name)
    # The call sequence is from left to right
    # Examples: 
    # - ("Function", "Main")
    # - ("If" : "Any")
    call_stack = []

    # Placeholder for config files
    def __init__(self):
        return


    def generate_region(self, env: List[Variable], return_type: List[Type]):
        # copy environment
        local_env = env.copy()

        # Output string
        output = ""

        while (True):
            p = random.randrange(90)

            # Define constant variable
            if p < 80:
                output += Variable.generate(self, local_env)

            elif p < 90:
                output += ForLoop.generate(self, local_env)

            elif p < 110:
                output += If.generate(self, local_env)

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
                    if(((self.call_stack[-1])[0] == "If" or (self.call_stack[-1])[0] == "ForLoop") and len(return_type) > 0):
                        output += Expression.emit("scf.yield", return_obj, return_type)
                    elif((self.call_stack[-1])[0] == "Function"):
                        if(len(return_type) > 0):
                            output += Expression.emit("func.return", return_obj, return_type)
                        else:
                            output += f"func.return {nl}"
                    
                    return output
                

    def generate_code(self):

        # =============== Defining modules ===============
        self.global_scope_ctr = 0

        generated_str = Module.generate(self, [])

        # =============== Defining main function ===============
        # available functions
        avail_funcs = []

        # =============== Output as MLIR ===============

        return generated_str

    """
    Parses a dictionary 'id' into MLIR code.
    self -- instance class data
    id -- dictionary from parse_dict
    """

    def parse_to_mlir(self, id):
        # cannot include backslash/newline in f-string expr
        # hack: use as variable an insert
        nl = '\n'

        if id['type'] == "condition":
            return f"scf.condition(%{id['condition_var'].name}) %{id['args'].name} : {id['args'].type.name}"

        if id['type'] == "whiledo":
            assignment_list = f"({', '.join(f'%{l.name} = %{r.name}' for (l,r) in id['assignment_list'])})"
            func_type = f": ({', '.join(f'%{l.type.name}' for (l,r) in id['assignment_list'])}) -> ({', '.join(f'{r.name}' for r in id['return_type'])})"

            return "scf.while " + assignment_list + func_type + f"{{ {nl}" + \
                f"{nl.join([self.parse_to_mlir(s) for s in id['statements_before']])}" + \
                self.parse_to_mlir(id["condition"].parse_dict()) + f"{nl} }} do {{ {nl}" + \
                f"{nl.join([self.parse_to_mlir(s) for s in id['statements_after']])}" + \
                f"{nl} }}"

        if id['type'] == "memreftype":
            dim_list = id['dimension_list']
            type = id['type']

            # Case for unknown rank
            if (len(dim_list) == 0):
                return f"memref<*x{type.name}>"

            str_dim = 'x'.join(f'%{"?" if i == -1 else i}' for i in dim_list)

            return f"memref<{str_dim}x{type.name}>"

        if id['type'] == "memrefload":
            memref = id['memref'].name
            indices = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['indices'])

            return f"memref.load %{memref}[{indices}] : {id['memref'].type.name}"

        if id['type'] == "memrefstore":
            value = id['value'].name
            memref = id['memref'].name
            indices = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['indices'])

            return f"memref.store %{value}, %{memref}[{indices}] : {id['memref'].type.name}"

        if id['type'] == "memrefalloc":
            arg_list = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['arg_list'])
            return f"memref.alloc({arg_list}) : {id['mem_type'].name}"

        if id['type'] == "memrefalloca":
            arg_list = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['arg_list'])

            return f"memref.alloca({arg_list}) : {id['mem_type'].name}"

        if id['type'] == "memrefcast":
            return f"memref.cast %{id['source'].name} : {id['from_type'].name} to {id['to_type'].name}"

        return "\n"


def main():
    s = MLIRSmith()
    print(s.generate_code())


if __name__ == "__main__":
    main()
