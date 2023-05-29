# Guarantees
- No guarantee of termination
- No ground truth (does not generate expected output)

# Safety
- Integer Safety
  - Signed Integer Overflow
    - Bounded loop vars
    - Safe math wrappers
- Array Safety
  - For-loops bounded to array size
  - Use modulo
  - Explicit bounds check

# Generation Process
- Select Op randomly
- Filter invalid Ops
- If Op requires values, randomly select them or define new ones
- If Op can have result types, randomly select one, respecting the constraints
- If Op has a region or requires another Op, recursively generate
- Update environments
- Execute safety checks and only commit if they succeed, else rollback 

# Environment
- Definitions of values (includes generating op and type)
- Definitions of symbols + bound op
- Call chain (avoid recursion)
- Parent Op (limit depth)
