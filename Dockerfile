FROM ubuntu:latest

RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m kernelb && echo "kernelb:kernelb" | chpasswd && adduser kernelb sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER kernelb

WORKDIR /home/kernelb

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
    ninja-build \
    ccache

# Setup git config
RUN git config --global user.name "${GIT_NAME}"
RUN git config --global user.email "${GIT_EMAIL}"
# Enable color output (optional)
RUN git config --global color.ui true
# Pull rebase by default or supply ARG PULL_REBASE=false
ARG PULL_REBASE=true
ENV PULL_REBASE=${PULL_REBASE}
RUN git config --global pull.rebase ${PULL_REBASE}

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "bash", "-c" ]
