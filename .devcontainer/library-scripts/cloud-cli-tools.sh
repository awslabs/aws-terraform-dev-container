#!/usr/bin/env bash
set -e

# This script installs AWS CLI, Azure CLI, and Google Cloud SDK

# Install AWS CLI v2
echo "Installing AWS CLI v2..."
curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
unzip -qq /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install
rm -rf /tmp/aws /tmp/awscliv2.zip

# Install Azure CLI
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Google Cloud SDK
echo "Installing Google Cloud SDK..."
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install -y google-cloud-cli

# Create directories for credentials
mkdir -p /home/vscode/.aws
mkdir -p /home/vscode/.azure
mkdir -p /home/vscode/.config/gcloud

# Set proper ownership
chown -R vscode:vscode /home/vscode/.aws
chown -R vscode:vscode /home/vscode/.azure
chown -R vscode:vscode /home/vscode/.config/gcloud

echo "Cloud CLI tools installation complete!"