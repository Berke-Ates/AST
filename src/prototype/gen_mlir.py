# @file
# @brief Prototype python program to generate MLIR code
# Usage: python3 gen_mlir.py
# Add description


from typing import List
import random


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
    typenames = ["i1", "i8", "i32", "i64", "f32", "f64"]

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

        # =============== Defining main function ===============
        # Randomly create return types
        return_types = []
        while random.random() < 0.5:
          return_types.append(Type(random.choice(self.typenames)))

        f1 = Function("main", [], return_types)
        
        while(True):

          if random.random() < 0.5:
            name = "var" + str(len(self.global_scope) + 1)
            type = Type(random.choice(self.typenames))

            if type.name == "f32" or type.name == "f64":
                val = random.uniform(0, 1)
            elif type.name == "i1":
                val = random.randint(0, 1)
            else :
                val = random.randint(-10, 10)

            const1 = Expression("arith.constant", [val], [type])
            v2 = Variable(name, type)
            f1.statements.append(v2.parse_dict(const1))
            self.global_scope.append(v2)
            
          # Check if we can generate a return Op
          available_return_types = [var.type for var in self.global_scope]
          
          # If so randomly decide to generate one
          if all(elem in available_return_types for elem in return_types):
            if random.random() < 0.5:
              for type in return_types:
                  possible_vars = [var for var in self.global_scope if var.type == type]
                  f1.return_vars.append(random.choice(possible_vars))
              break

        # Add function 'f1' to module statements
        module.statements.append(f1.parse_dict())

        # =============== Output as MLIR ===============
        # Parse to mlir from dictionary
        string = self.parse_to_mlir(module.parse_dict())
        return string

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
                    f"return {', '.join(f'%{r.name}' for r in id['return_vars'])} {':' if len(id['return_type']) > 0 else ''} {', '.join(f'{r.name}' for r in id['return_type'])} {nl} }}"
             
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
