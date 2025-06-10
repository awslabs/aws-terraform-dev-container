# Terraform Development Environment

A comprehensive VS Code Dev Container with tools to help you build and manage infrastructure with Terraform across AWS, Azure, and GCP.

## Features

- **Multi-cloud Support**: Pre-installed CLIs and tools for AWS, Azure, and GCP
- **Terraform Ecosystem**: Complete suite of Terraform tools including terraform-docs, tflint, tfsec, terrascan, and more
- **Security Best Practices**: Pre-commit hooks for security scanning and credential management
- **Developer Experience**: VS Code integration with tasks, settings, and extensions
- **Performance Optimization**: Caching strategies and optimized volume mounts

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop/) - Required for running containers
- [Visual Studio Code](https://code.visualstudio.com/) - The recommended IDE
- [VS Code Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) - Required for Dev Containers

## Getting Started

1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Open the folder in VS Code:
   ```bash
   code .
   ```

3. When prompted, click "Reopen in Container" or use the command palette (F1) and select "Remote-Containers: Reopen in Container"

4. Wait for the container to build and initialize (this may take a few minutes the first time)

## Included Tools

| Tool | Version | Description |
|------|---------|-------------|
| Terraform | 1.5.7 | Infrastructure as Code tool |
| AWS CLI | v2 | Command line interface for AWS |
| Azure CLI | Latest | Command line interface for Azure |
| Google Cloud SDK | Latest | Command line interface for GCP |
| terraform-docs | 0.16.0 | Documentation generator for Terraform modules |
| tflint | 0.47.0 | Terraform linter |
| tfsec | 1.28.0 | Security scanner for Terraform code |
| terrascan | 1.18.3 | Detect compliance and security violations |
| terragrunt | 0.48.0 | Thin wrapper for Terraform that provides extra tools |
| infracost | 0.10.28 | Cloud cost estimates for Terraform |
| checkov | 2.3.360 | Static code analysis tool for IaC |
| pre-commit | Latest | Framework for managing git pre-commit hooks |

## Authentication

The container includes helper scripts for authenticating with each cloud provider:

### AWS Authentication

```bash
.devcontainer/scripts/aws-auth.sh [--profile PROFILE] [--region REGION] [--sso]
```

### Azure Authentication

```bash
.devcontainer/scripts/azure-auth.sh [--subscription SUBSCRIPTION_ID] [--tenant TENANT_ID] [--service-principal] [--client-id CLIENT_ID] [--client-secret CLIENT_SECRET]
```

### GCP Authentication

```bash
.devcontainer/scripts/gcp-auth.sh [--project PROJECT_ID] [--credentials FILE_PATH]
```

## VS Code Tasks

The environment includes pre-configured VS Code tasks for common operations:

- **Terraform: Init** - Initialize a Terraform working directory
- **Terraform: Plan** - Generate and show an execution plan
- **Terraform: Apply** - Build or change infrastructure
- **Terraform: Destroy** - Destroy Terraform-managed infrastructure
- **Terraform: Validate** - Validate the Terraform files
- **Terraform: Format** - Rewrite Terraform configuration files to canonical format
- **TFLint: Run** - Run TFLint for static analysis
- **TFSec: Run** - Run TFSec for security scanning
- **Checkov: Run** - Run Checkov for compliance checks
- **Pre-commit: Run All Hooks** - Run all pre-commit hooks

To run a task, press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS) and select "Tasks: Run Task", then choose the task you want to run.

## Pre-commit Hooks

The environment includes pre-configured pre-commit hooks for Terraform validation, formatting, and security scanning. To install the hooks:

```bash
pre-commit install
```

## Environment Variables

Environment variables for Terraform and cloud providers can be configured in `.devcontainer/config/terraform.env`. The following variables are available:

### Terraform Configuration

- `TF_PLUGIN_CACHE_DIR` - Directory for caching Terraform plugins
- `TF_CLI_ARGS_init` - Arguments for `terraform init`
- `TF_CLI_ARGS_plan` - Arguments for `terraform plan`
- `TF_CLI_ARGS_apply` - Arguments for `terraform apply`
- `TF_LOG` - Terraform logging level

### AWS Provider Configuration

- `AWS_PROFILE` - AWS profile to use
- `AWS_REGION` - AWS region to use
- `AWS_SDK_LOAD_CONFIG` - Load config from AWS config file

### Azure Provider Configuration

- `ARM_SUBSCRIPTION_ID` - Azure subscription ID
- `ARM_TENANT_ID` - Azure tenant ID
- `ARM_CLIENT_ID` - Azure client ID
- `ARM_CLIENT_SECRET` - Azure client secret

### GCP Provider Configuration

- `GOOGLE_APPLICATION_CREDENTIALS` - Path to GCP service account key file
- `CLOUDSDK_CORE_PROJECT` - GCP project ID

## Customization

### Adding Custom Tools

To add custom tools to the container, modify the `.devcontainer/Dockerfile` and add your installation commands.

### Customizing VS Code Settings

VS Code settings can be customized in `.vscode/settings.json`.

### Customizing Pre-commit Hooks

Pre-commit hooks can be customized in `.pre-commit-config.yaml`.

## Volume Mounts

The container includes the following volume mounts:

- `~/.aws` - AWS credentials and configuration
- `~/.azure` - Azure credentials and configuration
- `~/.config/gcloud` - GCP credentials and configuration
- `~/.ssh` - SSH keys
- `terraform-cache` - Terraform plugin cache

## Security Considerations

- Credentials are mounted from the host to avoid storing them in the container
- Pre-commit hooks include security scanning for Terraform code
- Secret detection is enabled to prevent committing sensitive information

## Troubleshooting

### Common Issues

1. **Docker not running**: Ensure Docker is running on your system
2. **Permission issues**: Ensure you have the necessary permissions for the mounted volumes
3. **Authentication failures**: Check your credentials and ensure they are properly configured

### Logs

Container logs can be viewed in VS Code by clicking on the "Remote" indicator in the bottom-left corner and selecting "Show Container Log".

## License

This project is licensed under the MIT License - see the LICENSE file for details.
