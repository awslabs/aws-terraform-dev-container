# Terraform Development Environment Usage Guide

This document provides detailed usage instructions for the Terraform Development Environment.

## Table of Contents

- [Getting Started](#getting-started)
- [Working with Terraform](#working-with-terraform)
- [Cloud Provider Authentication](#cloud-provider-authentication)
- [Using Pre-commit Hooks](#using-pre-commit-hooks)
- [VS Code Tasks and Extensions](#vs-code-tasks-and-extensions)
- [Advanced Configuration](#advanced-configuration)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Getting Started

### Opening the Dev Container

1. Open VS Code in the project directory
2. Click on the green icon in the bottom-left corner
3. Select "Reopen in Container"
4. Wait for the container to build and initialize

### Initial Setup

Once the container is running, you'll see a welcome message with information about the installed tools and their versions. The following steps are recommended for initial setup:

1. Configure cloud provider authentication (see [Cloud Provider Authentication](#cloud-provider-authentication))
2. Install pre-commit hooks: `pre-commit install`
3. Initialize Terraform: `terraform init`

## Working with Terraform

### Basic Terraform Workflow

```bash
# Initialize Terraform
terraform init

# Format Terraform code
terraform fmt -recursive

# Validate Terraform code
terraform validate

# Plan changes
terraform plan -out=tfplan

# Apply changes
terraform apply tfplan

# Destroy infrastructure
terraform destroy
```

### Using Terraform with Multiple Environments

You can use Terraform workspaces or directory structures to manage multiple environments:

#### Using Workspaces

```bash
# Create workspaces
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

# List workspaces
terraform workspace list

# Select a workspace
terraform workspace select dev

# Run Terraform commands in the selected workspace
terraform plan -out=tfplan
```

#### Using Directory Structure

```
project/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
└── modules/
    ├── networking/
    ├── compute/
    └── storage/
```

### Using Terraform with Terragrunt

The environment includes Terragrunt for managing Terraform configurations:

```bash
# Initialize Terragrunt
terragrunt init

# Plan changes
terragrunt plan -out=tfplan

# Apply changes
terragrunt apply tfplan
```

## Cloud Provider Authentication

### AWS Authentication

```bash
# Basic authentication
.devcontainer/scripts/aws-auth.sh

# Authentication with profile
.devcontainer/scripts/aws-auth.sh --profile myprofile

# Authentication with region
.devcontainer/scripts/aws-auth.sh --region us-west-2

# Authentication with SSO
.devcontainer/scripts/aws-auth.sh --sso
```

### Azure Authentication

```bash
# Basic authentication (interactive)
.devcontainer/scripts/azure-auth.sh

# Authentication with subscription
.devcontainer/scripts/azure-auth.sh --subscription 00000000-0000-0000-0000-000000000000

# Authentication with service principal
.devcontainer/scripts/azure-auth.sh \
  --service-principal \
  --tenant 00000000-0000-0000-0000-000000000000 \
  --client-id 00000000-0000-0000-0000-000000000000 \
  --client-secret "your-client-secret"
```

### GCP Authentication

```bash
# Basic authentication (interactive)
.devcontainer/scripts/gcp-auth.sh

# Authentication with project
.devcontainer/scripts/gcp-auth.sh --project my-project-id

# Authentication with service account key
.devcontainer/scripts/gcp-auth.sh --credentials /path/to/service-account-key.json
```

## Using Pre-commit Hooks

### Installing Pre-commit Hooks

```bash
pre-commit install
```

### Running Pre-commit Hooks Manually

```bash
# Run on all files
pre-commit run --all-files

# Run specific hook
pre-commit run terraform_fmt --all-files
```

### Available Pre-commit Hooks

- `terraform_fmt`: Format Terraform files
- `terraform_validate`: Validate Terraform files
- `terraform_docs`: Generate documentation for Terraform modules
- `terraform_tflint`: Run TFLint
- `terraform_tfsec`: Run TFSec
- `terraform_checkov`: Run Checkov
- `shellcheck`: Check shell scripts
- `gitleaks`: Detect secrets in code

## VS Code Tasks and Extensions

### Running VS Code Tasks

1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS)
2. Select "Tasks: Run Task"
3. Choose the task you want to run

### Available VS Code Tasks

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
- **AWS: Login** - Login to AWS
- **Azure: Login** - Login to Azure
- **GCP: Login** - Login to GCP

### Installed VS Code Extensions

- HashiCorp Terraform
- Azure Terraform
- Terraform doc snippets
- YAML support
- Git integration (GitLens, Git Graph, Git History)
- Remote Containers
- Code Spell Checker
- Markdown All in One
- And more...

## Advanced Configuration

### Customizing Environment Variables

Edit `.devcontainer/config/terraform.env` to customize environment variables:

```bash
# Terraform Configuration
TF_PLUGIN_CACHE_DIR=/home/vscode/.terraform.d/plugin-cache
TF_CLI_ARGS_init="--upgrade"
TF_CLI_ARGS_plan="-compact-warnings"
TF_CLI_ARGS_apply="-compact-warnings"
# TF_LOG=DEBUG

# AWS Provider Configuration
AWS_PROFILE=default
AWS_REGION=us-west-2
AWS_SDK_LOAD_CONFIG=1

# Azure Provider Configuration
ARM_SUBSCRIPTION_ID=your-subscription-id
ARM_TENANT_ID=your-tenant-id
ARM_CLIENT_ID=your-client-id
ARM_CLIENT_SECRET=your-client-secret

# GCP Provider Configuration
GOOGLE_APPLICATION_CREDENTIALS=/home/vscode/.config/gcloud/application_default_credentials.json
CLOUDSDK_CORE_PROJECT=your-project-id
```

### Customizing TFLint Rules

Edit `.tflint.hcl` to customize TFLint rules:

```hcl
# Enable or disable specific rules
rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

# Add custom rules
rule "terraform_naming_convention" {
  enabled = true
  format = "snake_case"
}
```

### Adding Custom Tools

To add custom tools, create a new script in `.devcontainer/library-scripts/` and update the Dockerfile:

```dockerfile
# Install custom tool
COPY library-scripts/custom-tool.sh /tmp/library-scripts/
RUN chmod +x /tmp/library-scripts/custom-tool.sh
RUN /tmp/library-scripts/custom-tool.sh
```

## Best Practices

### Security Best Practices

1. **Never commit credentials**: Use environment variables or credential helpers
2. **Regularly rotate credentials**: Especially for service accounts
3. **Use least privilege**: Grant only the permissions needed
4. **Enable MFA**: Use multi-factor authentication for cloud providers
5. **Scan for secrets**: Use pre-commit hooks to detect secrets

### Terraform Best Practices

1. **Use modules**: Organize code into reusable modules
2. **Version pinning**: Pin provider and module versions
3. **Use remote state**: Store state in a remote backend
4. **Use variables**: Parameterize your configurations
5. **Document your code**: Use terraform-docs to generate documentation

### Development Workflow Best Practices

1. **Use branches**: Create feature branches for changes
2. **Run pre-commit hooks**: Validate code before committing
3. **Review plans**: Always review Terraform plans before applying
4. **Use workspaces or environments**: Separate development, staging, and production
5. **Automate testing**: Use automated testing for Terraform code

## Troubleshooting

### Common Issues and Solutions

#### Authentication Issues

**Issue**: Unable to authenticate with cloud provider
**Solution**: Check your credentials and ensure they are properly configured

```bash
# Check AWS credentials
aws sts get-caller-identity

# Check Azure credentials
az account show

# Check GCP credentials
gcloud auth list
```

#### Terraform Issues

**Issue**: Terraform init fails
**Solution**: Check your backend configuration and credentials

```bash
# Initialize with debug logging
TF_LOG=DEBUG terraform init
```

**Issue**: Terraform plan/apply fails
**Solution**: Check your provider configuration and credentials

```bash
# Plan with debug logging
TF_LOG=DEBUG terraform plan
```

#### Container Issues

**Issue**: Container fails to build
**Solution**: Check Docker logs and ensure Docker has enough resources

```bash
# Check Docker logs
docker logs <container-id>
```

**Issue**: Volume mounts not working
**Solution**: Check permissions and ensure the directories exist on the host

```bash
# Check permissions
ls -la ~/.aws ~/.azure ~/.config/gcloud ~/.ssh
```

### Getting Help

If you encounter issues not covered in this guide, please:

1. Check the documentation for the specific tool
2. Search for the error message online
3. Check the GitHub issues for this project
4. Reach out to the community for help
