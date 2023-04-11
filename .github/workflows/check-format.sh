#!/bin/bash

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# File extensions to be formatted
EXTENSIONS=("*.c" "*.cpp" "*.cc" "*.h" "*.hpp" "*.hh" "*.java" "*.js" "*.json" "*.m" "*.mm" "*.proto" "*.cs")

# Get a list of git submodule paths
submodule_paths=$(git submodule status --recursive | awk '{print "./" $2}')

# Initialize variables
errors=0
formatted_files=""

# Function to run clang-format dry-run on files matching the specified extensions
run_clang_format() {
  while read -r file; do
    if ! clang-format -style=file -n -Werror "$file" >/dev/null 2>&1; then
      formatted_files+="$file\n"
      errors=$((errors + 1))
    fi
  done
}

# Iterate through extensions and run clang-format dry-run
for ext in "${EXTENSIONS[@]}"; do
  # Run on the root directory
  run_clang_format < <(find . -maxdepth 1 -type f -iname "$ext")

  # Run on all non-submodule directories
  while read -r dir; do
    if ! printf '%s\n' "${submodule_paths[@]}" | grep -q -F -x "${dir}"; then
      run_clang_format < <(find "$dir" -type f -iname "$ext")
    fi
  done < <(find . -mindepth 1 -maxdepth 1 -type d)
done

# Display results
if [ $errors -gt 0 ]; then
  echo -e "${RED}Clang-format warnings found in the following files:${NC}"
  echo -e "$formatted_files"
  exit 1
else
  echo -e "${GREEN}No clang-format warnings found.${NC}"
  exit 0
fi
