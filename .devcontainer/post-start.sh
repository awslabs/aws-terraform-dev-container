#!/usr/bin/env bash
set -e

# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Load environment variables
if [ -f "/home/vscode/.devcontainer/config/terraform.env" ]; then
    echo "Loading Terraform environment variables..."
    set -a
    source "/home/vscode/.devcontainer/config/terraform.env"
    set +a
fi

# Make scripts executable
chmod +x /home/vscode/.devcontainer/scripts/*.sh

# Display welcome message
clear
printf "\e[0;32mTerraform Development Environment: $(basename $PWD)\e[0m\n\n"

# Display installed tools and versions
echo "=== Installed Tools ==="
echo "Terraform: $(terraform --version | head -n 1)"
echo "AWS CLI: $(aws --version)"
echo "Azure CLI: $(az --version | head -n 1)"
echo "Google Cloud SDK: $(gcloud --version | head -n 1)"
echo "Terraform Docs: $(terraform-docs --version)"
echo "TFLint: $(tflint --version)"
echo "TFSec: $(tfsec --version)"
echo "Terrascan: $(terrascan version)"
echo "Terragrunt: $(terragrunt --version)"
echo "Checkov: $(checkov --version)"
echo "Pre-commit: $(pre-commit --version)"
echo ""

# Display environment information
echo "=== Environment Information ==="
echo "Working Directory: $(pwd)"
echo "User: $(whoami)"
echo ""

# Display authentication status
echo "=== Authentication Status ==="
echo "AWS: Run '.devcontainer/scripts/aws-auth.sh' to authenticate"
echo "Azure: Run '.devcontainer/scripts/azure-auth.sh' to authenticate"
echo "GCP: Run '.devcontainer/scripts/gcp-auth.sh' to authenticate"
echo ""

# Display helpful commands
echo "=== Helpful Commands ==="
echo "terraform init - Initialize a Terraform working directory"
echo "terraform plan - Generate and show an execution plan"
echo "terraform apply - Builds or changes infrastructure"
echo "terraform validate - Validates the Terraform files"
echo "terraform fmt - Rewrites config files to canonical format"
echo "pre-commit run --all-files - Run pre-commit hooks on all files"
echo ""

# Display container information if available
if command -v devcontainer-info &> /dev/null; then
    devcontainer-info
fi
