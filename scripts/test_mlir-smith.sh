#!/bin/bash

# This script runs mlir-smith with multiple seeds and reports any crashes or
# timeouts

# Check if a path to the tool was provided.
if [ $# -ne 1 ]; then
  echo "Usage: $0 <path to mlir-smith>"
  exit 1
fi

# The path to the tool.
mlir_smith=$1

# Check if the tool exists and is executable.
if [ ! -x "$mlir_smith" ]; then
  echo "Error: mlir-smith does not exist at '$mlir_smith' or is not executable."
  exit 1
fi

# The range of seeds to test.
start_seed=0
end_seed=1000

# The timeout in seconds.
timeout=5

for ((seed = start_seed; seed <= end_seed; seed++)); do
  echo -ne "Running test with seed: $seed\r"

  timeout $timeout ./"$mlir_smith" --seed $seed >/dev/null 2>&1
  result=$?
  if [ $result -eq 124 ]; then
    echo -e "\nTimeout with seed: $seed"
    exit 1
  elif [ $result -ne 0 ]; then
    echo -e "\nCrash with seed: $seed"
    exit 1
  fi
done

echo -e "\nNo crashes or timeouts found in the seed range"
exit 0
