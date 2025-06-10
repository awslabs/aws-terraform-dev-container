#!/usr/bin/env bash
set -e

# This script installs common utilities and dependencies

# Install common packages
echo "Installing common utilities and dependencies..."
apt-get update
export DEBIAN_FRONTEND=noninteractive
apt-get -y install --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg \
    jq \
    lsb-release \
    make \
    python3 \
    python3-pip \
    software-properties-common \
    unzip \
    vim \
    wget \
    zip

# Install pre-commit
echo "Installing pre-commit..."
pip3 install pre-commit

# Create directory for Terraform plugin cache
mkdir -p /home/vscode/.terraform.d/plugin-cache
chown -R vscode:vscode /home/vscode/.terraform.d

# Create SSH directory
mkdir -p /home/vscode/.ssh
chown -R vscode:vscode /home/vscode/.ssh
chmod 700 /home/vscode/.ssh

echo "Common utilities installation complete!"