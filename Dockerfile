FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

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

# Download and install latest clang
RUN sudo curl -s https://apt.llvm.org/llvm.sh > /tmp/llvm.sh \
        && sudo chmod a+x /tmp/llvm.sh \
        && sudo /tmp/llvm.sh \
        && export LLVM_VERSION=$(cat /tmp/llvm.sh | grep -oP 'CURRENT_LLVM_STABLE=(\K[0-9.]+)') \
        && for i in $(ls /usr/lib/llvm-$LLVM_VERSION/bin) ; do sudo ln -s /usr/lib/llvm-$LLVM_VERSION/bin/$i /usr/bin/$i ; done \
        && sudo rm /tmp/llvm.sh

SHELL ["bash", "-c"]

# Install and configure fish shell
RUN sudo apt-get install -y fish \
        && sudo chsh -s /usr/bin/fish kernelb \
        && fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" \
        && fish -c "fisher install jethrokuan/z" \
        && fish -c "fisher install jethrokuan/fzf" \
        && fish -c "fisher install oh-my-fish/theme-bobthefish" \
        && fish -c "fisher install oh-my-fish/plugin-peco"

SHELL ["fish", "-c"]
