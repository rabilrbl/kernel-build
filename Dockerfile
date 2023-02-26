FROM ubuntu:latest

RUN useradd -l -u 55555 -G sudo -md /kernelb -s /bin/bash -p kernelb kernelb && \
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
    chown -hR kernelb:kernelb /kernelb
ENV HOME=/kernelb
ENV PATH=/kernelb/.local/bin:$PATH
WORKDIR /kernelb

RUN sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install -y \
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

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "bash", "-c" ]
