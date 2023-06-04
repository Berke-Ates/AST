#!/bin/bash

# This script differentially tests MLIR, LLVM, DCIR, and DaCe using the provided
# MLIR file

# Be safe
set -u # Disallow using undefined variables

# Check args
if [ $# -ne 2 ]; then
  echo "Usage: $0 <MLIR File> <Output Dir>"
  exit 1
fi

# Read args
mlir_file=$1
output_dir=$2

# Create output directory
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

# Helpers
scripts_dir=$(dirname "$0")

subdir="$output_dir"
mkdir -p "$subdir"
cp "$mlir_file" "$subdir"/input.mlir
mlir_file="$subdir"/input.mlir

# Generate binaries
if ! "$scripts_dir"/pipeline.sh "$mlir_file" "$subdir"; then
  echo "Compilation Error"
  exit 1
fi

# Compare outputs
binaries=("$subdir"/llvm/input.out "$subdir"/mlir/input.out "$subdir"/dace/input.out "$subdir"/dcir/input.out)

first_output=""
first_exit_status=0

for binary in "${binaries[@]}"; do
  # Change to the binary's directory
  pushd "$(dirname "$binary")" >/dev/null || exit 1

  LD_LIBRARY_PATH=. timeout 10s ./input.out &>out.txt
  echo "Exit status: $?" >>out.txt

  # Read the output and exit status from out.txt
  output=$(cat out.txt)
  exit_status=$(tail -n 1 out.txt | awk '{print $3}')

  # Change back to the original directory
  popd >/dev/null || exit 1

  if [ -z "$first_output" ]; then
    first_output="$output"
    first_exit_status="$exit_status"
  elif [ "$output" != "$first_output" ] || [ "$exit_status" != "$first_exit_status" ]; then
    echo "Different Outputs"
    exit 1
  fi
done

# Compare flags
if ! "$scripts_dir"/cmp_asm.sh "$subdir"/llvm/input.s "$subdir"/mlir/input.s "$subdir"/dcir/input.s "$subdir"/dace/input.s; then
  echo "Different flags"
  exit 1
fi

echo "ALL OK!"
