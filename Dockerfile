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
    python \
    llvm \
    clang \
    lld \
    cmake \
    ninja-build

WORKDIR /kernel

CMD ["bash"]
