# @file
# @brief Prototype python program to generate MLIR code
# Usage: python3 gen_mlir.py
# Add description


from typing import List


class Type():
    def __init__(self, name: str):
        self.name = name

class Module():
    def __init__(self):
        # need to be initialized after generation
        self.statements = []
    def parse_dict(self):
        return {"type": "module", "statements": self.statements}

class Expression():
    def __init__(self, primitive: str, args, return_type : List[Type]):
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
        if(expr.return_type == [self.type]):
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

    def __init__(self, ssa_vars: List[Variable], iter_args: List[(Variable, Variable)], return_type: List[Type], index_case: bool):
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

    # Placeholder for config files
    def __init__(self):
        return
    
    """
    Generates code in MLIR.
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
                return f"{id['primitive']} {', '.join([f'%{p.name}' for p in id['args']])} : {', '.join(f'{r.name}' for r in id['return_type'])}"

            case "forloop":
                ssa_vars = id['ssa_vars']
                iv = ssa_vars[0].name
                lb = ssa_vars[1].name
                ub = ssa_vars[2].name
                step = ssa_vars[3].name

                # Include iteration type if not index case
                it_type = ""
                if(not(id['index_case'])):
                    it_type = f": {iv.type.name}"

                return f"scf.for %{iv} = %{lb} to %{ub} step %{step} " + it_type + f"{nl}" + \
                    f"iter_args({', '.join(f'%{l.name} = %{r.name}' for (l,r) in id['iter_args'])}) ->  ({', '.join(f'{r.name}' for r in id['return_type'])}) {{ {nl}" + \
                    f"{nl.join([self.parse_to_mlir(s) for s in id['statements']])} {nl} }}" 

            case _:
                return "\n"

def main():
    s = MLIRSmith()
    print(s.generate_code())

if __name__ == "__main__":
    main()
