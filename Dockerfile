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
    cmake \
    gcc \
    ninja-build \
    ccache \
    zip \
    lsb-release \
    software-properties-common \
    gnupg


# Setup git config
ARG GIT_NAME="KernelB"
ENV GIT_NAME=${GIT_NAME}
ARG GIT_EMAIL="20230226+kernelb@users.noreply.github.com"
ENV GIT_EMAIL=${GIT_EMAIL}
RUN git config --global user.name "${GIT_NAME}"
RUN git config --global user.email "${GIT_EMAIL}"
# Enable color output (optional)
RUN git config --global color.ui true
# Pull rebase by default or supply ARG PULL_REBASE=false
ARG PULL_REBASE=true
ENV PULL_REBASE=${PULL_REBASE}
RUN git config --global pull.rebase ${PULL_REBASE}

# Install and setup latest repo, if needed
RUN sudo curl -s https://storage.googleapis.com/git-repo-downloads/repo -o /usr/local/bin/repo \
        && sudo chmod a+x /usr/local/bin/repo \
        && repo --version

# Download and install latest clang then setup as compiler
RUN sudo curl -s https://apt.llvm.org/llvm.sh > /tmp/llvm.sh \
        && sudo chmod a+x /tmp/llvm.sh \
        && sudo /tmp/llvm.sh \
        && export LLVM_VERSION=$(curl -s https://apt.llvm.org/llvm.sh | grep -oP 'CURRENT_LLVM_STABLE=(\K[0-9.]+)') \
        && sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${LLVM_VERSION} 100 \
        && sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${LLVM_VERSION} 100 \
        && clang --version \
        && clang++ --version

RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

CMD [ "bash", "-c" ]
