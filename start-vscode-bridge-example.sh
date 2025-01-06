#!/usr/bin/env sh
mkdir -p /home/yang/bridge.ssh
mkdir -p /home/yang/bridge.cargo
mkdir -p /home/yang/bridge.vscode-server

echo "VSCode Bridge for NixOS"
echo "----------------------------"
echo ""
echo "Some useful commands:"
echo ""
echo "- Connect to this container:"
echo "  $ ssh -p 3322 root@localhost"
echo "  (the default password of user root is 123456)"
echo ""
echo "- Copy SSH public key to this container:"
echo "  $ ssh-copy-id -p 3322 root@localhost"
echo ""
echo "- Stop this container:"
echo "  $ docker stop vscode-bridge"
echo ""

docker run \
  --rm \
  --mount type=bind,source="/home/yang/projects",target="/root/projects" \
  --mount type=bind,source="/home/yang/bridge.ssh",target="/root/.ssh" \
  --mount type=bind,source="/home/yang/bridge.cargo",target="/root/.cargo" \
  --mount type=bind,source="/home/yang/bridge.vscode-server",target="/root/.vscode-server" \
  --name vscode-bridge \
  --network host \
  --cap-add=NET_RAW \
  vscode-bridge-for-nixos