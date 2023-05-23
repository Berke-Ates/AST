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
check_tool clang-10   # libomp compatible version
check_tool clang++-10 # libomp compatible version
check_tool mlir-opt
check_tool mlir-translate
check_tool sdfg-opt
check_tool sdfg-translate
check_tool python3
check_tool llc
check_tool objdump

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
opt_lvl_dc="3"   # Optimization level for the data-centric optimizations (no -O)

# Dace Settings
DACE_compiler_cpu_executable="$(which clang++-10)"
export DACE_compiler_cpu_executable
CC=$(which clang-10)
export CC
CXX=$(which clang++-10)
export CXX
export DACE_compiler_cpu_openmp_sections=0
export DACE_instrumentation_report_each_invocation=0
export DACE_compiler_cpu_args="$flags $opt_lvl_cc"
export DACE_default_build_folder="$output_dir"/.dacecache
# export DACE_debugprint=verbose # for debugging
export PYTHONWARNINGS="ignore"

##===----------------------------------------------------------------------===##
## MLIR Pipeline
##===----------------------------------------------------------------------===##

# Optimizing with MLIR
mlir-opt --cse --inline "$mlir_file" \
  >"$output_dir"/"${input_name}"_mlir_opt.mlir

# Lower to LLVM dialect
mlir-opt --convert-scf-to-cf --convert-func-to-llvm --convert-cf-to-llvm \
  --convert-math-to-llvm --lower-host-to-llvm --reconcile-unrealized-casts \
  "$output_dir"/"${input_name}"_mlir_opt.mlir \
  >"$output_dir"/"${input_name}"_mlir_ll.mlir

# Translate
mlir-translate --mlir-to-llvmir "$output_dir"/"${input_name}"_mlir_ll.mlir \
  >"$output_dir"/"${input_name}"_mlir.ll

# Compile
llc $opt_lvl_cc --relocation-model=pic "$output_dir"/"${input_name}"_mlir.ll \
  -o "$output_dir"/"${input_name}"_mlir.s

# Assemble
# shellcheck disable=SC2086
clang $opt_lvl_cc $flags "$output_dir"/"${input_name}"_mlir.s \
  -o "$output_dir"/"${input_name}"_mlir.out -lm

##===----------------------------------------------------------------------===##
## DCIR Pipeline
##===----------------------------------------------------------------------===##

# Clear DaCe cache
rm -rf "$DACE_default_build_folder"

# Converting to SDFG Dialect
sdfg-opt --convert-to-sdfg "$output_dir"/"${input_name}"_mlir_opt.mlir \
  >"$output_dir"/"${input_name}"_dcir_sdfg.mlir

# Translating to SDFG
sdfg-translate --mlir-to-sdfg "$output_dir"/"${input_name}"_dcir_sdfg.mlir \
  >"$output_dir"/"$input_name"_dcir.sdfg

# Optimizing data-centrically with DaCe
python3 "$scripts_dir"/compile_sdfg.py "$output_dir"/"$input_name"_dcir.sdfg \
  "$output_dir"/"${input_name}"_dcir_opt.sdfg $opt_lvl_dc T

# Disassembling
# NOTE: We assume that the SDFG is called sdfg_0 (should be the case with
# mlir-dace)
obj_file=$(find "$DACE_default_build_folder" -iname sdfg_0.cpp.o)
objdump -d "$obj_file" >"$output_dir"/"${input_name}"_dcir_sdfg.s

##===----------------------------------------------------------------------===##
## DaCe Pipeline
##===----------------------------------------------------------------------===##

# Clear DaCe cache
rm -rf "$DACE_default_build_folder"

# Converting to SDFG Dialect
sdfg-opt --convert-to-sdfg "$mlir_file" \
  >"$output_dir"/"${input_name}"_dace_sdfg.mlir

# Translating to SDFG
sdfg-translate --mlir-to-sdfg "$output_dir"/"${input_name}"_dace_sdfg.mlir \
  >"$output_dir"/"$input_name"_dace.sdfg

# Optimizing data-centrically with DaCe
python3 "$scripts_dir"/compile_sdfg.py "$output_dir"/"$input_name"_dace.sdfg \
  "$output_dir"/"${input_name}"_dace_opt.sdfg $opt_lvl_dc T

# Disassembling
# NOTE: We assume that the SDFG is called sdfg_0 (should be the case with
# mlir-dace)
obj_file=$(find "$DACE_default_build_folder" -iname sdfg_0.cpp.o)
objdump -d "$obj_file" >"$output_dir"/"${input_name}"_dace_sdfg.s
