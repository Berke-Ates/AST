#!/bin/bash

# Check if at least two arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 file1.s file2.s [file3.s ...]"
  exit 1
fi

# Create a temporary file to store the function calls of the first assembly file
tempfile=$(mktemp)

# Extract the function calls of the first assembly file
grep -oP '(?<=call )\w+' "$1" | sort >"$tempfile"

# Shift the arguments to the left
shift

# Iterate over the rest of the assembly files
for file in "$@"; do
  # Create another temporary file to store the function calls of the current assembly file
  tempfile2=$(mktemp)

  # Extract the function calls of the current assembly file
  grep -oP '(?<=call )\w+' "$file" | sort >"$tempfile2"

  # Compare the function calls with those of the first assembly file
  if ! diff -q "$tempfile" "$tempfile2" >/dev/null; then
    # If they don't match, delete the temporary files and exit with code 1
    rm "$tempfile" "$tempfile2"
    exit 1
  fi

  # Delete the temporary file of the current assembly file
  rm "$tempfile2"
done

# Delete the temporary file of the first assembly file
rm "$tempfile"

# If all the function calls match, exit with code 0
exit 0
