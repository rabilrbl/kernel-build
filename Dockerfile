FROM ubuntu:latest

LABEL maintainer="Mohammed Rabil <rabil@techie.com>"

RUN apt-get update && apt-get install -y \
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
    ninja-build

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /kernel

CMD ["bash"]
