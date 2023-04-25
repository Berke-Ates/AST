# @file
# @brief Prototype python program to generate MLIR code
# Usage: python3 gen_mlir.py
# Add description


from typing import List


class Type():
    def __init__(self, name: str):
        self.name = name

# If the rank is unknown, leave the dimension list empty
# If the dimension is dynamic, use '-1' in the dimension list
class TypeMemref(Type):
    def __init__(self, dimension_list: List[int], type: Type):
        self.dimension_list = dimension_list
        self.type = type

        # Case for unknown rank
        if(len(dimension_list) == 0):
            return f"memref<*x{type.name}>"
        
        str_dim = 'x'.join(f'{"?" if i == -1 else i}' for i in dimension_list)

        self.name = f"memref<{str_dim}x{type.name}>"


    def parse_dict(self):
        return {"type": "typememref", "name": self.name, "dimension_list": self.dimension_list, "type": self.type}

class Module():
    def __init__(self):
        # need to be initialized after generation
        self.statements = []
    def parse_dict(self):
        return {"type": "module", "statements": self.statements}

class Expression():
    def __init__(self, primitive: str, args: List, return_type : List[Type]):
        self.primitive = primitive
        self.args = args
        self.return_type = return_type

    def parse_dict(self):
        return {"type": "expression", "primitive": self.primitive, "args": self.args, "return_type": self.return_type}

class Variable():
    def __init__(self, name: str, v_type: Type):
        self.name = name
        self.type = v_type

    def parse_dict(self, expr : Expression):
        return {"type": "assignment", "variable": self.name, "value": expr}
    
class Function():
    def __init__(self, name: str, params: List[Variable], return_type: List[Type]):
        self.name = name
        self.params = params
        self.return_type = return_type

        # need to be initialized after generation
        self.statements = []
        self.return_vars = []

        # for internal usage
        self.local_scope = params #initial local scope is parameter set

    def parse_dict(self):
            return {"type": "function", "name": self.name, "params": self.params,
                    "return_vars" : self.return_vars, "return_type": self.return_type, 
                    "statements": self.statements
            }

class ForLoop():
    # SSA vars are initialized in order:
    # ssa_vars[0]: iteration var
    # ssa_vars[1]: lower bound var
    # ssa_vars[2]: upper bound var
    # ssa_vars[3]: step var

    def __init__(self, ssa_vars: List[Variable], iter_args: List[tuple[Variable, Variable]], return_type: List[Type], index_case: bool):
        if(len(ssa_vars) != 4):
            raise ValueError("SSA array requires 4 variables")

        self.ssa_vars = ssa_vars
        self.return_type = return_type
        self.iter_args = iter_args
        self.statements = []
        self.index_case = index_case

        # for internal usage
        self.local_scope = ssa_vars

    def parse_dict(self):
            return {"type": "forloop", "ssa_vars": self.ssa_vars,
                    "return_type" : self.return_type, "iter_args": self.iter_args, 
                    "statements": self.statements, "index_case" : self.index_case
            }
    
class If():
    def __init__(self, condition_var: Variable, return_type: List[Variable]):
        if(condition_var.type.name != "ui1"):
            raise ValueError("Condition variable must be 1-bit signless integer")
        self.condition_var = condition_var
        self.return_type = return_type
        self.statements_then = []
        self.statements_else = []
        self.local_scope = []

    def parse_dict(self):
        return {"type": "if", "condition_var" : self.condition_var, "return_type": self.return_type,
                "statements_then": self.statements_then, "statements_else": self.statements_else}

class Condition():
    def __init__(self, condition_var: Variable, args: Variable):
        self.condition_var = condition_var
        self.args = args # either zero or one argument

    def parse_dict(self):
        return {"type": "condition", "condition_var" : self.condition_var, "args": self.args}
    
class WhileDo():
    def __init__(self, condition: Condition, assignment_list: List[tuple[Variable, Variable]], return_type: List[Variable]):
        self.condition = condition
        self.assignment_list = assignment_list
        self.return_type = return_type
        
        # Before and after regions
        self.statements_before = []
        self.statements_after = []
        self.local_scope_before = []
        self.local_scope_after = []

    def parse_dict(self):
        return {"type": "whiledo", "condition" : self.condition, "assignment_list": self.assignment_list, "return_type": self.return_type,
                "statements_before": self.statements_before, "statements_after": self.statements_after}
    
class MemrefLoad(Expression):
    def __init__(self, memref: Variable, indices):
        self.memref = memref
        self.indices = indices # list of constants and variables
        self.mem_type = type

    def parse_dict(self):
        return {"type": "memrefload", "memref": self.memref, "indices": self.indices}
    
class MemrefStore(Expression):
    def __init__(self, value: Variable, memref: Variable, indices):
        self.value = value
        self.memref = memref
        self.indices = indices # list of constants and variables

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
    global_scope = []


    # Define types for usage
    t_i1 = Type("i1")
    t_i8 = Type("i8")
    t_i32 = Type("i32")
    t_i64 = Type("i64")

    t_f32 = Type("f32")
    t_f64 = Type("f64")

    t_index = Type("index")

    t_ui1 = Type("ui1")

    # Placeholder for config files
    def __init__(self):
        return
    
    """
    Generates example code in MLIR.
    self -- instance class data
    """
    def generate_code(self):

        # =============== Defining modules ===============
        module = Module()

        # =============== Defining primitives ===============

        # Define variables (Needs to be added to global scope in actual code)
        v1 = Variable("x", self.t_i32)
        v2 = Variable("y", self.t_i32)
        v3 = Variable("z", self.t_i32)


        # Define a constant
        const1 = Expression("arith.constant", [42], [self.t_i32])
        module.statements.append(v2.parse_dict(const1))

        # Define an expression
        # TODO: Generator should pull primitives and their definitions (arguments, return type etc.) from a file or something
        addi = Expression("arith.addi", [v1, v2], [self.t_i32])

        # Add 'v3 = addi ..' to module statements
        module.statements.append(v3.parse_dict(addi))

        # =============== Defining Functions ===============
        vf1 = v1 = Variable("a", self.t_i64) # define parameter variable
        f1 = Function("count", [vf1], [self.t_i64, self.t_i64])

        # Add statements and return variables to function
        # In this example, we just return the params twice
        f1.return_vars.extend([vf1, vf1])

        # Add function 'f1' to module statements
        module.statements.append(f1.parse_dict())

        # =============== Defining For Loops ===============

        # Define SSA variables
        iv = Variable("iv", self.t_i32)
        lb = Variable("lb", self.t_i32)
        ub = Variable("ub", self.t_i32)
        step = Variable("step", self.t_i32)

        # Define iteration variables
        sum_iter = Variable("sum_iter", self.t_f32)
        sum_0 = Variable("sum_0", self.t_f32)

        # Initialize For loop
        l1 = ForLoop([iv, lb, ub, step], [(sum_iter, sum_0)], [self.t_f32], False)

        # Add statements and yield to loop
        sum_next = Variable("sum_next", self.t_f32)

        addf = Expression("arith.addf", [sum_iter, sum_iter], [self.t_f32])

        l1.statements.append(sum_next.parse_dict(addf))

        yld1 = Expression("scf.yield", [sum_next], [self.t_f32])

        l1.statements.append(yld1.parse_dict())

        # Add for loop to module statements
        module.statements.append(l1.parse_dict())


        # =============== Defining If/Else statements ===============

        # Set up condition variable (type = ui1)
        cond = Variable("cond", self.t_ui1)
        if1 = If(cond, [self.t_f32])

        yld2 = Expression("scf.yield", [sum_next], [self.t_f32])

        # Add yield to then block
        if1.statements_then.append(yld2.parse_dict())

        # Add if statement to module statements
        module.statements.append(if1.parse_dict())

        # =============== Defining WhileDo loop ===============

        # Set up condition for the while do loop
        next = Variable("next", self.t_f32)
        while_cond = Condition(cond, next)

        # Set up assignment list
        arg1 = Variable("arg1", self.t_f32)
        init1 = Variable("init1", self.t_f32)

        w1 = WhileDo(while_cond, [(arg1, init1)], [self.t_f32])

        # Add 'before' region
        addf2 = Expression("arith.addf", [arg1, arg1], [self.t_f32])
        w1.statements_before.append(next.parse_dict(addf2))

        # Add 'after' region
        yld3 = Expression("scf.yield", [arg1], [self.t_f32])
        w1.statements_after.append(yld3.parse_dict())

        module.statements.append(w1.parse_dict())


        # =============== Defining Memref operations ===============

        # Defining memref types
        mr1 = TypeMemref([8, -1], self.t_f32)

        # ***** Allocating some array (memref.alloc) *****
        A = Variable("A", mr1)
        maA = MemrefAlloc([8], mr1)

        module.statements.append(A.parse_dict(maA))

        # ***** Allocating some array on the stack (memref.alloca) *****
        B = Variable("B", mr1)
        maB = MemrefAlloca([16], mr1)

        module.statements.append(B.parse_dict(maB))

        # ***** Deallocating some array *****
        # Note: Since dealloc is formatted as an expression, it is used like one
        mdB = Expression("memref.dealloc", [B], [mr1])

        module.statements.append(mdB.parse_dict())

        # ***** Loading some value from A *****
        loc1 = Variable("1", self.t_i32)
        loc2 = Variable("2", self.t_i32)
        loc12 = Variable("12", self.t_f32)

        memload = MemrefLoad(A, [loc1, loc2])

        module.statements.append(loc12.parse_dict(memload))

        # ***** Storing some value to A *****
        v4 = Variable("100", self.t_f32)

        module.statements.append(MemrefStore(v4, A, [loc1, 7]).parse_dict())

        # ***** Casting values *****
        mr2 = TypeMemref([-1, -1], self.t_f32)
        C = Variable("C", mr2)

        module.statements.append(C.parse_dict(MemrefCast(A, mr1, mr2)))

        # =============== Output as MLIR ===============
        # Parse to mlir from dictionary
        string = self.parse_to_mlir(module.parse_dict())
        print(string)

    """
    Parses a dictionary 'id' into MLIR code.
    self -- instance class data
    id -- dictionary from parse_dict
    """
    def parse_to_mlir(self, id):
        # cannot include backslash/newline in f-string expr
        # hack: use as variable an insert
        nl = '\n'

        match id['type']:
            case "module":
                return f"module {{ {nl} {nl.join([self.parse_to_mlir(s) for s in id['statements']])} {nl} }}"

            case "assignment":
                return f"%{id['variable']} = {self.parse_to_mlir(id['value'].parse_dict())}\n"

            case "function":
                return f"func.func @{id['name']} ({', '.join([f'%{p.name} : {p.type.name}' for p in id['params']])}) -> ({', '.join(f'{r.name}' for r in id['return_type'])}) {{ {nl}" + \
                    f"{nl.join([self.parse_to_mlir(s) for s in id['statements']])}" + \
                    f"return {', '.join(f'%{r.name}' for r in id['return_vars'])} : {', '.join(f'{r.name}' for r in id['return_type'])} {nl} }}"
            
            case "expression":
                args = ', '.join(f"{i if isinstance(i, (int, float)) else '%'+i.name}" for i in id['args'])

                return f"{id['primitive']} {args} : {', '.join(f'{r.name}' for r in id['return_type'])}"

            case "forloop":
                ssa_vars = id['ssa_vars']
                iv = ssa_vars[0].name
                lb = ssa_vars[1].name
                ub = ssa_vars[2].name
                step = ssa_vars[3].name

                # Include iteration type if not index case
                it_type = ""
                if(not(id['index_case'])):
                    it_type = f": {ssa_vars[0].type.name}"

                return f"scf.for %{iv} = %{lb} to %{ub} step %{step} " + it_type + f"{nl}" + \
                    f"iter_args({', '.join(f'%{l.name} = %{r.name}' for (l,r) in id['iter_args'])}) ->  ({', '.join(f'{r.name}' for r in id['return_type'])}) {{ {nl}" + \
                    f"{nl.join([self.parse_to_mlir(s) for s in id['statements']])} {nl} }}" 
            
            case "condition":
                return f"scf.condition(%{id['condition_var'].name}) %{id['args'].name} : {id['args'].type.name}"
            
            case "if":
                cond = id["condition_var"].name
                else_output = ""
                first_line = f"scf.if %{cond} -> ({', '.join(f'{r.name}' for r in id['return_type'])}) {{ {nl}"

                # Check if else case is populated
                if(len(id["statements_else"]) != 0):
                    else_output = " else {{ {nl}" + \
                    f"{nl.join([self.parse_to_mlir(s) for s in id['statements_else']])} {nl} }}" 

                # Check if return type is empty, and adjust first line
                if(len(id["return_type"]) == 0):
                    first_line = f"scf.if %{cond} {{ {nl}"

                return first_line + \
                    f"{nl.join([self.parse_to_mlir(s) for s in id['statements_then']])} {nl} }}" + \
                    else_output
            
            case "whiledo":
                
                assignment_list = f"({', '.join(f'%{l.name} = %{r.name}' for (l,r) in id['assignment_list'])})"
                func_type = f": ({', '.join(f'%{l.type.name}' for (l,r) in id['assignment_list'])}) -> ({', '.join(f'{r.name}' for r in id['return_type'])})"

                return "scf.while " + assignment_list + func_type + f"{{ {nl}" + \
                    f"{nl.join([self.parse_to_mlir(s) for s in id['statements_before']])}" + \
                    self.parse_to_mlir(id["condition"].parse_dict()) + f"{nl} }} do {{ {nl}" + \
                    f"{nl.join([self.parse_to_mlir(s) for s in id['statements_after']])}" + \
                    f"{nl} }}"
            
            case "memreftype":
                dim_list = id['dimension_list']
                type = id['type']

                # Case for unknown rank
                if(len(dim_list) == 0):
                    return f"memref<*x{type.name}>"
                
                str_dim = 'x'.join(f'%{"?" if i == -1 else i}' for i in dim_list)

                return f"memref<{str_dim}x{type.name}>"

            case "memrefload":
                memref = id['memref'].name
                indices = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['indices'])

                return f"memref.load %{memref}[{indices}] : {id['memref'].type.name}"
            
            case "memrefstore":
                value = id['value'].name
                memref = id['memref'].name
                indices = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['indices'])

                return f"memref.store %{value}, %{memref}[{indices}] : {id['memref'].type.name}"
            
            case "memrefalloc":
                arg_list = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['arg_list'])
                
                return f"memref.alloc({arg_list}) : {id['mem_type'].name}"
            
            case "memrefalloca":
                arg_list = ', '.join(f"{i if isinstance(i, int) else '%'+i.name}" for i in id['arg_list'])
                
                return f"memref.alloca({arg_list}) : {id['mem_type'].name}"
            
            case "memrefcast":
                return f"memref.cast %{id['source'].name} : {id['from_type'].name} to {id['to_type'].name}"

            case _:
                return "\n"

def main():
    s = MLIRSmith()
    print(s.generate_code())

if __name__ == "__main__":
    main()
