FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    bc \
    git \
    unzip \
    wget \
    python3 \
    python-is-python3 \
    llvm \
    clang \
    lld \
    cmake \
    gcc \
    ninja-build
    
# Setup CCACHE
ENV USE_CCACHE=1
# Find the path to the ccache binary
RUN export CCACHE_PATH=$(which ccache)

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /kernel

ENTRYPOINT [ "sh", "-c" ]
