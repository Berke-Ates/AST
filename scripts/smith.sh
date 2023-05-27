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

compilation_error_dir="$output_dir"/compilation_error
flag_diff_dir="$output_dir"/flag_diff
normal_dir="$output_dir"/normal

mkdir -p "$compilation_error_dir"
mkdir -p "$flag_diff_dir"
mkdir -p "$normal_dir"

# Helpers
scripts_dir=$(dirname "$0")

for ((i = 0; i <= 100; i++)); do
  subdir="$output_dir"/smith_$i
  mkdir -p "$subdir"
  mlir_file="$subdir"/input.mlir

  $mlir_smith -o "$mlir_file"

  if ! "$scripts_dir"/pipeline.sh "$mlir_file" "$subdir"; then
    mv "$subdir" "$compilation_error_dir"
    continue
  fi

  if ! "$scripts_dir"/cmp_asm.sh "$subdir"/llvm/input.s "$subdir"/mlir/input.s "$subdir"/dcir/input.s "$subdir"/dace/input.s; then
    mv "$subdir" "$flag_diff_dir"
    continue
  fi

  mv "$subdir" "$normal_dir"
done
