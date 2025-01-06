FROM ubuntu:24.04

# Disable the dialog when installing "tzdata", which will block building image.
ENV DEBIAN_FRONTEND=noninteractive

# Update repo first
RUN apt update

# Install base development tools
RUN apt install build-essential gdb -y

# Install essential tools
RUN apt install openssh-server vim git -y

# Install other optional packages
RUN apt install iproute2 iputils-ping -y

# Install Rust toolchain
RUN apt install rustup -y \
    && rustup default stable

# Add some optional features, such as the MUSL library
RUN apt install musl-tools -y \
    && rustup target install x86_64-unknown-linux-musl

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

# Start `sshd` service
CMD ["/usr/sbin/sshd", "-D"]
