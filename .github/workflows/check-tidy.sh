#!/bin/bash

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# File extensions to be checked
EXTENSIONS=("*.c" "*.cpp" "*.cc" "*.h" "*.hpp" "*.hh")

# Get a list of git submodule paths
submodule_paths=$(git submodule status --recursive | awk '{print "./" $2}')

# Initialize variables
errors=0
tidy_files=""

# Function to run clang-tidy on files matching the specified extensions
run_clang_tidy() {
  while read -r file; do
    if ! clang-tidy -header-filter=.* -p . -warnings-as-errors=* "$file" >/dev/null 2>&1; then
      tidy_files+="$file\n"
      errors=$((errors + 1))
    fi
  done
}

# Iterate through extensions and run clang-tidy
for ext in "${EXTENSIONS[@]}"; do
  # Run on the root directory
  run_clang_tidy < <(find . -maxdepth 1 -type f -iname "$ext")

  # Run on all non-submodule directories
  while read -r dir; do
    if ! printf '%s\n' "${submodule_paths[@]}" | grep -q -F -x "${dir}"; then
      run_clang_tidy < <(find "$dir" -type f -iname "$ext")
    fi
  done < <(find . -mindepth 1 -maxdepth 1 -type d)
done

# Display results
if [ $errors -gt 0 ]; then
  echo -e "${RED}Clang-tidy warnings found in the following files:${NC}"
  echo -e "$tidy_files"
  exit 1
else
  echo -e "${GREEN}No clang-tidy warnings found.${NC}"
  exit 0
fi
