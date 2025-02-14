FROM ubuntu:24.04

# Disable the dialog when installing "tzdata", which will block building image.
ENV DEBIAN_FRONTEND=noninteractive

# Update repo first
RUN apt update && apt upgrade -y

# Install base development tools
RUN apt install build-essential -y

# Install common development tools
RUN apt install libncurses-dev pkg-config autoconf automake libtool ninja-build cmake meson \
    musl musl-tools \
    clang lld \
    valgrind gdb \
    file -y

# Install essential tools
RUN apt install wget vim git -y

# Install common packages
RUN apt install openssh-server iproute2 iputils-ping -y

# Install common languages
RUN apt install rustup golang nodejs npm pipx default-jdk maven -y

# Install Rust toolchain
RUN rustup default stable

# Install Rust additional targets
RUN rustup target install x86_64-unknown-linux-musl

# Change the work directory
WORKDIR /root

# Set password "123456" for user "root"
RUN echo 'root:123456' | chpasswd

# `sshd` needs this folder
RUN mkdir /var/run/sshd

# Enable root SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Change port to 3322
RUN sed -i 's/#Port 22/Port 3322/' /etc/ssh/sshd_config

# Port
EXPOSE 3322

# Start `sshd` service in foreground
# CMD ["/usr/sbin/sshd", "-D"]

# Start sshd and bash
CMD /usr/sbin/sshd ; /usr/bin/bash
