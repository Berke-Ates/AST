#!/bin/bash

# Be safe
set -e          # Fail script when subcommand fails
set -u          # Disallow using undefined variables
set -o pipefail # Prevent errors from being masked

# Check if at least two arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <MLIR File> <Output File>"
  exit 1
fi

# Create a C file
printf "#include <stdio.h>\n" >"$2"

# Extract the external function names from the MLIR file
grep -oP '(?<=func private @)[^()]*' "$1" | awk '{print $1}' |
  while read -r func_name; do
    # Generate a C function that prints its name
    {
      printf "void %s() {\n" "$func_name"
      printf "    printf(\"%s\\\n\");\n" "$func_name"
      printf "}\n"
      printf "\n"
    } >>"$2"
  done
