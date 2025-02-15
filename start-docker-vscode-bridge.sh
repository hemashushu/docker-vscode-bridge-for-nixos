#!/usr/bin/env bash
mkdir -p /home/yang/bridge.ssh
mkdir -p /home/yang/bridge.cargo
mkdir -p /home/yang/bridge.vscode-server

echo "VSCode Bridge for NixOS"
echo "----------------------------"
echo ""
echo "- Connect to this container:"
echo "  $ ssh -p 3322 root@localhost"
echo "  (the default password of user root is 123456)"
echo ""
echo "- Copy SSH public key to this container:"
echo "  $ ssh-copy-id -p 3322 root@localhost"
echo ""
echo ">> Please keep the current container running"
echo ">> when you use VSCode Remote to connect to the current container."
echo ""

docker run \
  -it \
  --rm \
  --mount type=bind,source="${HOME}/bridge.ssh",target="/root/.ssh" \
  --mount type=bind,source="${HOME}/bridge.cargo",target="/root/.cargo" \
  --mount type=bind,source="${HOME}/bridge.vscode-server",target="/root/.vscode-server" \
  --mount type=bind,source="${HOME}/projects",target="/root/projects" \
  --mount type=bind,source="${HOME}/EXT",target="/root/EXT" \
  --name vscode-bridge \
  --network host \
  --cap-add=NET_RAW \
  vscode-bridge-for-nixos:2.0.0