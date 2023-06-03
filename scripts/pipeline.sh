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

# Logfile
log_file="$output_dir"/logfile.txt
rm -rf "$log_file"
touch "$log_file"
add_log_section() {
  # fills a line of logfile like this:
  printf "\n##===----------------------------------------------------------------------===##\n## %s\n##===----------------------------------------------------------------------===##\n" "$1" >>"$log_file"
}

# Check tools
add_log_section "Tool Versions"
check_tool() {
  if ! command -v "$1" &>/dev/null; then
    echo "$1 could not be found"
    rm -rf "$output_dir"
    exit 1
  fi
  printf "\n%s version: " "$1" >>"$log_file"
  "$1" --version >>"$log_file"
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
check_tool opt
check_tool llc

add_log_section "Submodule Commits"
missing_submodules=0

# Check each submodule
while read -r path; do
  if [[ ! -d "$path" ]]; then
    echo "Submodule $path is missing"
    missing_submodules=$((missing_submodules + 1))
  else
    remote=$(git config --file .gitmodules --get "submodule.$path.url")
    commit=$(git submodule status "$path" | awk '{ print $1 }')
    {
      printf "\nSubmodule: %s\n" "$path"
      echo "Remote: $remote"
      echo "Commit: $commit"
    } >>"$log_file"
  fi
done < <(git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

# Check if any submodules are missing
if [[ $missing_submodules -gt 0 ]]; then
  echo "Some submodules are missing!"
  exit 1
fi

# Clear .dacecache
rm -rf .dacecache

add_log_section "Environment Variables"

# Helpers
input_name=$(basename "${mlir_file%.*}")
scripts_dir=$(dirname "$0")
{
  printf "\nmlir_file: %s" "$mlir_file"
  printf "\ninput_name: %s" "$input_name"
  printf "\nscripts_dir: %s\n" "$scripts_dir"
} >>"$log_file"

# Flags for optimizations
flags="-fPIC -march=native"
opt_lvl_cc="-O3" # Optimization level for the control-centric optimizations
opt_lvl_dc="3"   # Optimization level for the data-centric optimizations (no -O)
{
  printf "\nflags: %s" "$flags"
  printf "\nopt_lvl_cc: %s" "$opt_lvl_cc"
  printf "\nopt_lvl_dc: %s\n" "$opt_lvl_dc"
} >>"$log_file"

# Dace Settings
DACE_compiler_cpu_executable="$(which clang++-10)"
export DACE_compiler_cpu_executable
CC=$(which clang-10)
export CC
CXX=$(which clang++-10)
export CXX
export DACE_compiler_cpu_openmp_sections=0
export DACE_instrumentation_report_each_invocation=0
export DACE_compiler_cpu_args="$flags -O0"
export DACE_include_folder="$scripts_dir"/../dace/dace/runtime/include
# export DACE_debugprint=verbose # for debugging
export PYTHONWARNINGS="ignore"

{
  printf "\nDACE_compiler_cpu_executable: %s" "$DACE_compiler_cpu_executable"
  printf "\nCC: %s" "$CC"
  printf "\nCXX: %s" "$CXX"
  printf "\nDACE_compiler_cpu_openmp_sections: %s" "$DACE_compiler_cpu_openmp_sections"
  printf "\nDACE_instrumentation_report_each_invocation: %s" "$DACE_instrumentation_report_each_invocation"
  printf "\nDACE_compiler_cpu_args: %s" "$DACE_compiler_cpu_args"
  printf "\nDACE_include_folder: %s" "$DACE_include_folder"
  printf "\nPYTHONWARNINGS: %s\n" "$PYTHONWARNINGS"
} >>"$log_file"

##===----------------------------------------------------------------------===##
## External functions generation
##===----------------------------------------------------------------------===##
add_log_section "External Functions Generation"
printf "\n" >>"$log_file"
exec >>"$log_file" 2>&1 # Redirect the output to the log file
set -x

funcs_lib="$output_dir"/funcs.o
"$scripts_dir"/gen_ext_func.sh "$mlir_file" "$output_dir"/funcs.c
clang -c "$output_dir"/funcs.c -o "$funcs_lib"
absolute_path_funcs_lib=$(realpath "$funcs_lib")
export DACE_compiler_cpu_libs="$absolute_path_funcs_lib"

set +x

##===----------------------------------------------------------------------===##
## MLIR Pipeline
##===----------------------------------------------------------------------===##
add_log_section "MLIR Pipeline"
printf "\n" >>"$log_file"

# Create subfolder
mlir_dir="$output_dir"/mlir
if [ ! -d "$mlir_dir" ]; then
  mkdir -p "$mlir_dir"
fi

# Logging
exec >>"$log_file" 2>&1 # Redirect the output to the log file
set -x

# Optimizing with MLIR
mlir-opt --cse --canonicalize --symbol-dce --loop-invariant-code-motion \
  --inline "$mlir_file" >"$mlir_dir"/"${input_name}"_opt.mlir

# Lower to LLVM dialect
mlir-opt --convert-scf-to-cf --convert-func-to-llvm --convert-cf-to-llvm \
  --convert-math-to-llvm --lower-host-to-llvm --reconcile-unrealized-casts \
  "$mlir_dir"/"${input_name}"_opt.mlir \
  >"$mlir_dir"/"${input_name}"_ll.mlir

# Translate
mlir-translate --mlir-to-llvmir "$mlir_dir"/"${input_name}"_ll.mlir \
  >"$mlir_dir"/"${input_name}".ll

# Generate assembly
llc -O0 "$mlir_dir"/"${input_name}".ll \
  >"$mlir_dir"/"${input_name}".s

# Compile & Assemble
# shellcheck disable=SC2086
clang -O0 $flags "$funcs_lib" "$mlir_dir"/"${input_name}".ll \
  -o "$mlir_dir"/"${input_name}".out -lm

set +x

##===----------------------------------------------------------------------===##
## LLVM Pipeline
##===----------------------------------------------------------------------===##
add_log_section "LLVM Pipeline"
printf "\n" >>"$log_file"

# Create subfolder
llvm_dir="$output_dir"/llvm
if [ ! -d "$llvm_dir" ]; then
  mkdir -p "$llvm_dir"
fi

# Logging
exec >>"$log_file" 2>&1 # Redirect the output to the log file
set -x

# Lower to LLVM dialect
mlir-opt --convert-scf-to-cf --convert-func-to-llvm --convert-cf-to-llvm \
  --convert-math-to-llvm --lower-host-to-llvm --reconcile-unrealized-casts \
  "$mlir_file" >"$llvm_dir"/"${input_name}"_ll.mlir

# Translate
mlir-translate --mlir-to-llvmir "$llvm_dir"/"${input_name}"_ll.mlir \
  >"$llvm_dir"/"${input_name}".ll

# Optimize
opt $opt_lvl_cc -S "$llvm_dir"/"${input_name}".ll \
  >"$llvm_dir"/"${input_name}"_opt.ll

# Generate assembly
llc -O0 "$llvm_dir"/"${input_name}"_opt.ll \
  >"$llvm_dir"/"${input_name}".s

# Compile & Assemble
# shellcheck disable=SC2086
clang -O0 $flags "$funcs_lib" "$llvm_dir"/"${input_name}"_opt.ll \
  -o "$llvm_dir"/"${input_name}".out -lm

set +x

##===----------------------------------------------------------------------===##
## DCIR Pipeline
##===----------------------------------------------------------------------===##
add_log_section "DCIR Pipeline"
printf "\n" >>"$log_file"

# Create subfolder
dcir_dir="$output_dir"/dcir
if [ ! -d "$dcir_dir" ]; then
  mkdir -p "$dcir_dir"
fi

# Logging
exec >>"$log_file" 2>&1 # Redirect the output to the log file
set -x

# Clear DaCe cache
export DACE_default_build_folder="$dcir_dir"/.dacecache
rm -rf "$DACE_default_build_folder"

# Converting to SDFG Dialect
sdfg-opt --convert-to-sdfg "$mlir_dir"/"${input_name}"_opt.mlir \
  >"$dcir_dir"/"${input_name}".mlir

# Translating to SDFG
sdfg-translate --mlir-to-sdfg "$dcir_dir"/"${input_name}".mlir \
  >"$dcir_dir"/"$input_name".sdfg

# Optimizing data-centrically with DaCe
python3 "$scripts_dir"/compile_sdfg.py "$dcir_dir"/"$input_name".sdfg \
  "$dcir_dir"/"${input_name}"_opt.sdfg $opt_lvl_dc T

# Disassembling
# NOTE: We assume that the SDFG is called sdfg_0 (should be the case with
# mlir-dace)
obj_file=$(find "$DACE_default_build_folder" -iname sdfg_0.cpp.o)
objdump -d "$obj_file" >"$dcir_dir"/"${input_name}".s

# Rewrite to return the return type
sed -i '/free(_arg0);/d' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/return 0;/d' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/}/i\int val = *_arg0;' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/int val = \*_arg0;/a\free(_arg0);' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/free(_arg0);/a\return val;' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp

# Compile
cp "$DACE_default_build_folder"/sdfg_0/build/libsdfg_0.so "$dcir_dir"
# shellcheck disable=SC2086
clang++ -O0 $flags -I "$DACE_include_folder" \
  "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp \
  "$dcir_dir"/libsdfg_0.so -o "$dcir_dir"/"${input_name}".out -lm

set +x

##===----------------------------------------------------------------------===##
## DaCe Pipeline
##===----------------------------------------------------------------------===##
add_log_section "DaCe Pipeline"
printf "\n" >>"$log_file"

# Create subfolder
dace_dir="$output_dir"/dace
if [ ! -d "$dace_dir" ]; then
  mkdir -p "$dace_dir"
fi

# Logging
exec >>"$log_file" 2>&1 # Redirect the output to the log file
set -x

# Clear DaCe cache
export DACE_default_build_folder="$dace_dir"/.dacecache
rm -rf "$DACE_default_build_folder"

# Converting to SDFG Dialect
sdfg-opt --convert-to-sdfg "$mlir_file" >"$dace_dir"/"${input_name}".mlir

# Translating to SDFG
sdfg-translate --mlir-to-sdfg "$dace_dir"/"${input_name}".mlir \
  >"$dace_dir"/"$input_name".sdfg

# Optimizing data-centrically with DaCe
python3 "$scripts_dir"/compile_sdfg.py "$dace_dir"/"$input_name".sdfg \
  "$dace_dir"/"${input_name}"_opt.sdfg $opt_lvl_dc T

# Disassembling
# NOTE: We assume that the SDFG is called sdfg_0 (should be the case with
# mlir-dace)
obj_file=$(find "$DACE_default_build_folder" -iname sdfg_0.cpp.o)
objdump -d "$obj_file" >"$dace_dir"/"${input_name}".s

# Rewrite to return the return type
sed -i '/free(_arg0);/d' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/return 0;/d' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/}/i\int val = *_arg0;' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/int val = \*_arg0;/a\free(_arg0);' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp
sed -i '/free(_arg0);/a\return val;' "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp

# Compile
cp "$DACE_default_build_folder"/sdfg_0/build/libsdfg_0.so "$dace_dir"
# shellcheck disable=SC2086
clang++ -O0 $flags -I "$DACE_include_folder" \
  "$DACE_default_build_folder"/sdfg_0/sample/sdfg_0_main.cpp \
  "$dace_dir"/libsdfg_0.so -o "$dace_dir"/"${input_name}".out -lm

set +x
