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
* (Automatically generates test harnesses, enabling seamless integration with 
testing frameworks)

## Getting Started
To start using MLIRsmith, follow these steps:

1. Clone the repository: `git clone --recurse-submodules --shallow-submodules 
https://github.com/Berke-Ates/AST`
2. Build the project by following the instructions in the [Building](#building) 
section.
3. Register the desired dialects using the provided interface.
4. Run MLIRsmith with the appropriate configuration options to generate random 
MLIR code.

For more details on using MLIRsmith and its various options, please refer to the
 [Usage](#usage) section.

## Building
Please follow these steps to build MLIRsmith:

1. Ensure you have the required dependencies installed: LLVM, MLIR, and CMake.
2. Create a build directory: `mkdir build && cd build`
3. Configure the project with CMake: `cmake -G Ninja ..`
4. Build the project: `ninja`

## Usage

Once MLIRsmith is built, you can run it with the following command:
```sh
./mlir-smith [options]
```

The available options include:

* `-p, --show-dialects`: Print the list of registered dialects
* `-d, --dialects`: A comma-separated list of dialects to generate code for.
* `-n, --num-tests`: The number of test cases to generate (default: 1).
* `-o, --output`: The output directory for the generated code (default: current 
directory).
* `-s, --seed`: The seed for the random number generator (default: system time).
* `-c, --config`: The path to a configuration file with additional options.


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

## Contributing
We welcome contributions to MLIRsmith! If you are interested in contributing, 
please follow the guidelines in our [CONTRIBUTING.md](CONTRIBUTING.md) file. We 
encourage you to submit bug reports, propose new features, and create pull 
requests to improve MLIRsmith.

## License
MLIRsmith is licensed under the [BSD-3-Clause license](LICENSE).

