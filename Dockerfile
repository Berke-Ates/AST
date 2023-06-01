################################################################################
### GENERAL SETUP
################################################################################

FROM ubuntu:22.04 as llvm

# User directory
ENV USER=user
ENV HOME=/home/user
WORKDIR $HOME

# Install dependencies
RUN apt-get update -y && \ 
  apt-get install -y --no-install-recommends \
  wget=1.21.2-2ubuntu1 \
  git=1:2.34.1-1ubuntu1.5 \
  cmake=3.22.1-1ubuntu1.22.04.1 \
  ninja-build=1.10.1-1 \
  clang=1:14.0-55~exp2 \
  lld=1:14.0-55~exp2 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

################################################################################
### Install mlir-dace
################################################################################

# Make sure submodules are initialized
RUN git clone --depth 1 --branch cgo23 https://github.com/spcl/mlir-dace.git
WORKDIR $HOME/mlir-dace
RUN git submodule update --init --recursive --depth 1

# Build MLIR
WORKDIR $HOME/mlir-dace/llvm-project/build

RUN cmake -G Ninja ../llvm \
  -DLLVM_ENABLE_PROJECTS="mlir" \
  -DLLVM_TARGETS_TO_BUILD="host" \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DLLVM_ENABLE_LLD=ON \
  -DLLVM_INSTALL_UTILS=ON && \
  ninja

# Build mlir-dace
WORKDIR $HOME/mlir-dace/build

RUN cmake -G Ninja .. \
  -DMLIR_DIR=$HOME/mlir-dace/llvm-project/build/lib/cmake/mlir \
  -DLLVM_EXTERNAL_LIT=$HOME/mlir-dace/llvm-project/build/bin/llvm-lit \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_BUILD_TYPE=Release && \
  ninja && \
  mkdir -p $HOME/bin && \
  cp $HOME/mlir-dace/build/bin/* $HOME/bin && \
  rm -rf $HOME/mlir-dace

# Go home
WORKDIR $HOME

################################################################################
### Install LLVM/MLIR
################################################################################

# TODO: Build mlir-opt, mlir-translate, clang, clang++, llc

################################################################################
### Reduce Image Size
################################################################################

# Copy binaries
FROM ubuntu:22.04

# User directory
ENV USER=user
ENV HOME=/home/user
WORKDIR $HOME

# Move dotfiles
RUN mv /root/.bashrc . && mv /root/.profile .

# Make terminal colorful
ENV TERM=xterm-color

# Install dependencies
RUN apt-get update -y && \ 
  apt-get install -y --no-install-recommends \
  wget=1.21.2-2ubuntu1  \
  git=1:2.34.1-1ubuntu1.5 \
  cmake=3.22.1-1ubuntu1.22.04.1 \
  make=4.3-4.1build1 \
  ninja-build=1.10.1-1 \
  clang-10=1:10.0.0-4ubuntu1 \
  gcc=4:11.2.0-1ubuntu1 \
  lld=1:14.0-55~exp2  \
  python3-pip=22.0.2+dfsg-1 \
  python3=3.10.6-1~22.04 \
  python3-dev=3.10.6-1~22.04 \
  gpg=2.2.27-3ubuntu2.1 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Launch bash shell at home
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["cd $HOME && bash"]

# Python dependencies
RUN pip install --upgrade --no-cache-dir pip==22.3.1

# Copy Binaries
COPY --from=llvm $HOME/bin $HOME/bin

# Add binaries to PATH
ENV PATH=$HOME/bin:$PATH

################################################################################
### Install dace
################################################################################

RUN git clone --depth 1 --branch cgo23 https://github.com/Berke-Ates/dace.git

WORKDIR $HOME/dace
RUN git submodule update --init --recursive --depth 1 && \
  pip install --no-cache-dir --editable . && \
  pip install --no-cache-dir mxnet-mkl==1.6.0 numpy==1.23.1

# Go home
WORKDIR $HOME

################################################################################
### Copy files over
################################################################################

COPY ./diff_test.config ./diff_test.config
COPY ./scripts ./scripts
COPY ./README.md ./README.md
COPY ./LICENSE ./LICENSE
