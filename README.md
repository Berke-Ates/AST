# MLIRsmith: A Random MLIR Code Generator

Welcome to MLIRsmith, a powerful tool designed to generate random MLIR 
(Multi-Level Intermediate Representation) code for a registered set of dialects. 
MLIRsmith aims to simplify the process of testing and validating MLIR compilers, 
optimizers, and code transformations by providing a diverse set of MLIR test 
cases. Inspired by the success of CSmith in generating random C programs, 
MLIRsmith follows a similar approach to help detect and diagnose errors in the 
MLIR ecosystem.

## Features
* Generates random MLIR code for a specified set of dialects.
* Supports a wide range of MLIR dialects, with an easy-to-use interface for 
registering new dialects.
* Ensures the generation of well-formed and semantically valid MLIR code.
* Provides a variety of configuration options for controlling the complexity and
 scope of the generated code.

## Getting Started
To start using MLIRsmith, follow these steps:

1. Clone the repository: `git clone --recurse-submodules --shallow-submodules 
https://github.com/Berke-Ates/AST`
2. Install the requirements by following the instructions in the 
[Requirements](#requirements) section.
3. Build the project by following the instructions in the [Building](#building) 
section.
4. Run MLIRsmith with the appropriate configuration options to generate random 
MLIR code. 

For more details on using MLIRsmith and its various options, please refer to the
 [Usage](#usage) section.

## Requirements
MLIRsmith relies on other projects that are incorporated as submodules. 
To ensure a seamless experience, follow these steps for each project if you 
haven't already installed them. First, make sure to obtain the submodules on 
your local machine by executing the command:
```sh
git submodule update --init --recursive
```
This will initialize and update all necessary submodules and their nested 
submodules in a single step.

### DaCe (Optional)
Install DaCe with the following commands:
```sh
cd dace
pip install --editable .
pip install mxnet-mkl==1.6.0 numpy==1.23.1
```

### MLIR-DaCe (Optional)
If the MLIR commits of this project and MLIR-DaCe differ, you may need to build
the MLIR submodule of MLIR-DaCe:

```sh
cd mlir-dace/llvm-project
mkdir build && cd build

cmake -G Ninja ../llvm \
  -DLLVM_ENABLE_PROJECTS="mlir" \
  -DLLVM_TARGETS_TO_BUILD="host" \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DLLVM_ENABLE_LLD=ON \
  -DLLVM_INSTALL_UTILS=ON

ninja
```

To build MLIR-DaCe run the following commands:
```sh
cd mlir-dace
mkdir build && cd build

RUN cmake -G Ninja .. \
  -DMLIR_DIR=<Path to llvm-project>/build/lib/cmake/mlir \
  -DLLVM_EXTERNAL_LIT=<Path to llvm-project>/build/bin/llvm-lit \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_BUILD_TYPE=Release

ninja
```

Note: Replace `<Path to llvm-project>` by the absolute path to the 
`llvm-project` folder of this project (if applicable) or of the MLIR-DaCe 
project.

## Building
Please follow these steps to build MLIRsmith:

```sh
cd llvm-project
mkdir build && cd build

cmake -G Ninja ../llvm \
  -DLLVM_ENABLE_PROJECTS="mlir" \
  -DLLVM_TARGETS_TO_BUILD="host" \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DLLVM_ENABLE_LLD=ON \
  -DLLVM_INSTALL_UTILS=ON

ninja
```

Note: Depending on your machine this may take a while.

## Usage

Once MLIRsmith is built, you can run it with the following command:
```sh
./mlir-smith [options]
```

The available options include:

* `---dump`: Dump the used configuration.
* `-o`: The output directory for the generated code (default: stdout).
* `--seed`: The seed for the random number generator (default: system time).
* `-c`: The path to a configuration file with additional options.


## File Structure
This project is organized into several directories, each containing specific 
components of the MLIRsmith tool. Below is an overview of the file structure, 
detailing the contents and purpose of each directory:

* `llvm-project`: This directory contains a submodule of the LLVM Project, 
including the MLIR framework. It provides essential support for working with 
MLIR code and its various dialects.
* `dace`: The Dace directory houses a submodule for the Data-Centric Parallel 
Programming (DaCe) framework. DaCe is used to represent MLIR programs as 
Stateful Dataflow Multigraphs (SDFGs), enabling powerful optimizations and 
transformations.
* `mlir-dace`: This directory contains the MLIR-DaCe integration code. It is 
responsible for bridging the gap between the MLIR and DaCe frameworks, ensuring 
seamless interaction between the two.
* `scripts`: The scripts folder provides various utility scripts to assist in 
building, testing, and working with MLIRsmith. These scripts automate common 
tasks, making it easier for users to interact with the tool and manage the 
generated code.

The main source files for MLIRsmith are located at the root level of the 
project. These files implement the core functionality of the tool, including the
 generation of random MLIR code and the registration and management of dialects.

## License
MLIRsmith is licensed under the [BSD-3-Clause license](LICENSE).

