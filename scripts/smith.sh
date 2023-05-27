#!/bin/bash

# This script uses mlir-smith to differentially test MLIR, LLVM, DCIR and DaCe.

# Be safe
set -u # Disallow using undefined variables

# Check args
if [ $# -ne 2 ]; then
  echo "Usage: ./smith.sh <Path to mlir-smith> <Output Dir>"
  exit 1
fi

# Read args
mlir_smith=$1
output_dir=$2

# Create output directory
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

comp_err_dir="$output_dir"/comp_err_dir
exe_diff_dir="$output_dir"/exe_diff
flag_diff_dir="$output_dir"/flag_diff
normal_dir="$output_dir"/normal

mkdir -p "$comp_err_dir"
mkdir -p "$exe_diff_dir"
mkdir -p "$flag_diff_dir"
mkdir -p "$normal_dir"

# Helpers
scripts_dir=$(dirname "$0")

for ((i = 0; i <= 10; i++)); do
  subdir="$output_dir"/smith_$i
  mkdir -p "$subdir"
  mlir_file="$subdir"/input.mlir

  # Generate an MLIR file using mlir-smith until it contains 'func private'
  # (external call)
  while true; do
    $mlir_smith -o "$mlir_file"
    if grep -q 'func private' "$mlir_file"; then
      break
    fi
  done

  # Generate binaries
  if ! "$scripts_dir"/pipeline.sh "$mlir_file" "$subdir"; then
    mv "$subdir" "$comp_err_dir"
    continue
  fi

  # Compare outputs
  binaries=("$subdir"/llvm/input.out "$subdir"/mlir/input.out "$subdir"/dace/input.out "$subdir"/dcir/input.out)

  first_output=""
  first_exit_status=0

  for binary in "${binaries[@]}"; do
    output=$(timeout 10s "$binary")
    exit_status=$?

    if [ -z "$first_output" ]; then
      first_output="$output"
      first_exit_status="$exit_status"
    elif [ "$output" != "$first_output" ] || [ "$exit_status" != "$first_exit_status" ]; then
      mv "$subdir" "$exe_diff_dir"
      continue 2
    fi
  done

  # Compare flags
  if ! "$scripts_dir"/cmp_asm.sh "$subdir"/llvm/input.s "$subdir"/mlir/input.s "$subdir"/dcir/input.s "$subdir"/dace/input.s; then
    mv "$subdir" "$flag_diff_dir"
    continue
  fi

  mv "$subdir" "$normal_dir"
done
