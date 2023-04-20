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
        self.statements = []
    def parse_dict(self):
        return {"type": "module", "statements": self.statements}
    
class Function():
    def __init__(self, name: str, return_type: Type):
        self.name = name
        self.return_type = return_type
        self.local_scope = []
        self.statements = []

    def parse_dict(self, params: List[str], statements : List):
            return {"type": "function", "name": self.name, "params": params, "statements": statements}
    
class Expression():
    def __init__(self, primitive: str, args, return_type : Type):
        self.primitive = primitive
        self.args = args
        self.type = return_type

    def parse_dict(self):
        return {"type": "expression", "primitive": self.primitive, "args": self.args, "return_type": self.type}

class Variable():
    def __init__(self, name: str, v_type: Type):
        self.name = name
        self.type = v_type

    def parse_dict(self, expr : Expression):
        if(expr.type == self.type):
            return {"type": "assignment", "variable": self.name, "value": expr}

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

        # Define module
        module = Module()

        # Define variables (Needs to be added to global scope in actual code)
        v1 = Variable("x", self.t_i32)
        v2 = Variable("y", self.t_i32)
        v3 = Variable("z", self.t_i32)

        # Define an expression
        # TODO: Generator should pull primitives and arguments from a file or something
        addi = Expression("arith.addi", [v1, v2], self.t_i32)

        # Add 'v3 = expr' to statements
        module.statements.append(v3.parse_dict(addi))

        # Parse to mlir from dictionary
        string = self.parse_to_mlir(module.parse_dict())
        print(string)

    """
    Parses a dictionary 'id' into MLIR code.
    self -- instance class data
    id -- dictionary from parse_dict
    """
    def parse_to_mlir(self, id):
        match id['type']:
            case "module":
                return f"module {{\n {', '.join([self.parse_to_mlir(s) for s in id['statements']])} }}"
            case "assignment":
                return f"%{id['variable']} = {self.parse_to_mlir(id['value'].parse_dict())}\n"
            case "function":
                return f"func @{id['name']}({[(p.name,p.type) for p in id['params']]}) {{ \n \
                    {[self.parse_to_mlir(s) for s in id['statements']]} \n \
                }}"
            case "expression":
                return f"{id['primitive']} {', '.join([f'%{p.name}' for p in id['args']])} : {id['return_type'].name}"
            case _:
                return "\n"

def main():
    s = MLIRSmith()
    print(s.generate_code())

if __name__ == "__main__":
    main()
