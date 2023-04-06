#!/bin/bash

# Desc: Compiles a MLIR file containing the SCF, MEMREF, ARITH, MATH and BUILTIN
#       dialects with LLVM and DaCe
# Usage: ./pipeline.sh <MLIR File> <Output Dir>

# Be safe
set -e          # Fail script when subcommand fails
set -u          # Disallow using undefined variables
set -o pipefail # Prevent errors from being masked

# Check args
if [ $# -ne 2 ]; then
  echo "Usage: ./pipeline.sh <MLIR File> <Output Dir>"
  exit 1
fi

# Read args
mlir_file=$1
output_dir=$2

# Check tools
check_tool() {
  if ! command -v "$1" &>/dev/null; then
    echo "$1 could not be found"
    exit 1
  fi
}

check_tool clang
check_tool clang++
check_tool mlir-opt
check_tool sdfg-opt
check_tool sdfg-translate
check_tool python3

# Create output directory
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

# Clear .dacecache
rm -rf .dacecache

# Helpers
input_name=$(basename "${mlir_file%.*}")
scripts_dir=$(dirname "$0")

# Flags for optimizations
flags="-fPIC -march=native"
opt_lvl_cc="-O3" # Optimization level for the control-centric optimizations
opt_lvl_dc="3"   # Optimization level for the data-centric optimizations

# Dace Settings
DACE_compiler_cpu_executable="$(which clang++)"
export DACE_compiler_cpu_executable
CC=$(which clang)
export CC
CXX=$(which clang++)
export CXX
export DACE_compiler_cpu_openmp_sections=0
export DACE_instrumentation_report_each_invocation=0
export DACE_compiler_cpu_args="$flags $opt_lvl_cc"
export PYTHONWARNINGS="ignore"

##===----------------------------------------------------------------------===##
## MLIR Pipeline
##===----------------------------------------------------------------------===##

# Optimizing with MLIR
mlir-opt --cse --inline "$mlir_file" >"$output_dir"/"${input_name}"_opt.mlir

# TODO: Lower to LLVM Dialect

# TODO: Translate to LLVM IR

# TODO: Compile with LLC & Clang

##===----------------------------------------------------------------------===##
## DCIR Pipeline
##===----------------------------------------------------------------------===##

# Converting to SDFG Dialect
sdfg-opt --convert-to-sdfg "$mlir_file" >"$output_dir"/"${input_name}"_sdfg.mlir

# Translating to SDFG
sdfg-translate --mlir-to-sdfg "$output_dir"/"${input_name}"_sdfg.mlir \
  >"$output_dir"/"$input_name".sdfg

# Optimizing data-centrically with DaCe
python3 "$scripts_dir"/compile_sdfg.py "$output_dir"/"$input_name".sdfg \
  "$output_dir"/"${input_name}"_opt.sdfg $opt_lvl_dc T
