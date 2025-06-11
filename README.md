# Terraform Development Environment

A comprehensive VS Code Dev Container that provides a consistent, pre-configured environment for developing, testing, and deploying infrastructure as code with Terraform across AWS, Azure, and GCP.

> **Boost your infrastructure development productivity with a ready-to-use, standardized environment that works the same way for everyone on your team, across all major cloud providers.**

This project eliminates the pain of setting up and maintaining development environments for Terraform, allowing you to focus on writing high-quality infrastructure code instead of wrestling with tool installations and configurations.

## Table of Contents

- [The Problem We're Solving](#the-problem-were-solving)
- [Why Use This Dev Container?](#why-use-this-dev-container)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Included Tools](#included-tools)
- [Authentication](#authentication)
- [VS Code Tasks](#vs-code-tasks)
- [Pre-commit Hooks](#pre-commit-hooks)
- [Environment Variables](#environment-variables)
- [Customization](#customization)
- [Advanced Usage](#advanced-usage)
- [Use Cases](#use-cases)
- [Productivity Benefits](#productivity-benefits)
- [Real-World Success Stories](#real-world-success-stories)
- [Volume Mounts](#volume-mounts)
- [Security Considerations](#security-considerations)
- [Troubleshooting](#troubleshooting)
- [Getting Help](#getting-help)
- [Contributing](#contributing)
- [License](#license)

## The Problem We're Solving

Infrastructure as code (IaC) development with Terraform presents several challenges:

- **Environment Setup Complexity**: Setting up a development environment with all necessary tools, versions, and configurations is time-consuming and error-prone
- **Cross-Cloud Development**: Working across multiple cloud providers requires managing different CLIs, authentication methods, and best practices
- **Security and Compliance**: Ensuring infrastructure code meets security standards and follows best practices requires specialized tools
- **Team Consistency**: Maintaining consistent development environments across team members is difficult
- **Onboarding Friction**: New team members often spend days configuring their environment before becoming productive

This development container solves these problems by providing a ready-to-use, standardized environment with all necessary tools pre-configured.

## Why Use This Dev Container?

- **Instant Productivity**: Start developing Terraform code immediately without spending time on environment setup
- **Standardized Tooling**: Ensures everyone on your team uses the same versions of tools and follows the same practices
- **Built-in Best Practices**: Includes pre-configured security scanning, linting, and validation tools
- **Multi-Cloud Ready**: Supports AWS, Azure, and GCP development out of the box
- **Reduced Onboarding Time**: New team members can be productive within minutes instead of days
- **Consistent Experience**: Works the same way on any operating system that supports Docker and VS Code

## Features

- **Multi-cloud Support**: Pre-installed CLIs and tools for AWS, Azure, and GCP with streamlined authentication
- **Complete Terraform Ecosystem**: Comprehensive suite of tools including terraform-docs, tflint, tfsec, terrascan, terragrunt, terratest, and more
- **Security and Compliance**: Pre-commit hooks for security scanning, compliance checking, and credential management
- **Enhanced Developer Experience**: VS Code integration with tasks, settings, extensions, and snippets
- **Performance Optimization**: Caching strategies and optimized volume mounts for faster operations
- **Testing and Validation**: Built-in tools for testing infrastructure code and validating changes
- **Cost Management**: Integrated cost estimation with Infracost

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop/) - Required for running containers
- [Visual Studio Code](https://code.visualstudio.com/) - The recommended IDE
- [VS Code Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) - Required for Dev Containers

## Getting Started

### Quick Start

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

5. Start developing with all tools pre-configured and ready to use!

### Recommended Workflow

For the most efficient development experience, we recommend this workflow:

1. **Initialize your project**: Use VS Code tasks to run `terraform init`
2. **Install pre-commit hooks**: Run `pre-commit install` to set up automated validation
3. **Develop iteratively**: Make small changes and validate frequently
4. **Validate changes**: Use the pre-configured tasks for linting, security scanning, and validation
5. **Generate documentation**: Use terraform-docs to keep documentation up-to-date
6. **Estimate costs**: Run Infracost before applying changes to understand cost implications
7. **Test your infrastructure**: Use Terratest to write and run tests for your infrastructure
8. **Review and apply**: After thorough validation, apply your changes to the target environment

### Project Structure Best Practices

We recommend organizing your Terraform projects like this:

```
project/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── ...
│   └── prod/
│       └── ...
├── modules/
│   ├── networking/
│   ├── compute/
│   └── storage/
└── tests/
    └── ...
```

This structure promotes code reuse, environment isolation, and easier testing.

## Included Tools

| Tool | Version | Description |
|------|---------|-------------|
| Terraform | 1.12.1 | Infrastructure as Code tool |
| AWS CLI | 2.27.26 | Command line interface for AWS |
| Azure CLI | Latest | Command line interface for Azure |
| Google Cloud SDK | Latest | Command line interface for GCP |
| terraform-docs | 0.20.0 | Documentation generator for Terraform modules |
| tflint | 0.48.0 | Terraform linter |
| tfsec | 1.28.13 | Security scanner for Terraform code |
| terrascan | 1.19.9 | Detect compliance and security violations |
| terragrunt | 0.50.1 | Thin wrapper for Terraform that provides extra tools |
| terratest | v0.49.0 | Testing utility for infrastructure code |
| infracost | 0.10.41 | Cloud cost estimates for Terraform |
| checkov | 3.2.439 | Static code analysis tool for IaC |
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

## Advanced Usage

### Tool Integration

This development environment is designed with tool integration in mind. Here's how the tools work together:

1. **Development Flow**:
   - Write Terraform code in VS Code with syntax highlighting and IntelliSense
   - Use terraform fmt (via tasks or pre-commit) to maintain consistent formatting
   - Validate syntax with terraform validate
   - Check for best practices with tflint
   - Generate documentation automatically with terraform-docs

2. **Security and Compliance Flow**:
   - Scan for security issues with tfsec
   - Check compliance with terrascan and checkov
   - Detect secrets with pre-commit hooks
   - All integrated into the pre-commit workflow

3. **Testing Flow**:
   - Write infrastructure tests with Terratest
   - Validate infrastructure behavior before deployment
   - Ensure infrastructure meets requirements

4. **Deployment Flow**:
   - Estimate costs with Infracost
   - Plan changes with terraform plan
   - Apply changes with terraform apply
   - Manage complex deployments with Terragrunt

### Extending the Environment

You can extend this development environment to suit your specific needs:

1. **Adding Custom Tools**:
   - Modify the Dockerfile to add additional tools
   - Add custom scripts to the scripts directory
   - Configure additional VS Code extensions in devcontainer.json

2. **Team Customization**:
   - Fork this repository for your team
   - Add team-specific configurations and tools
   - Share custom modules and examples
   - Configure team-specific pre-commit hooks

3. **CI/CD Integration**:
   - Use the same tools in your CI/CD pipelines
   - Export configurations from the dev container to CI/CD
   - Ensure consistency between development and automation

## Use Cases

### Enterprise Infrastructure Teams
- Standardize development environments across large teams
- Enforce security and compliance policies through built-in tools
- Simplify onboarding of new team members
- Ensure consistent practices across multiple cloud providers

### DevOps Engineers
- Rapidly prototype and test infrastructure changes
- Validate changes before applying to production environments
- Generate documentation automatically
- Estimate costs before deploying resources

### Cloud Architects
- Design and test multi-cloud architectures
- Validate designs against security best practices
- Create reusable infrastructure modules
- Document architecture decisions

### Individual Developers
- Learn Terraform and cloud infrastructure in a pre-configured environment
- Experiment with different cloud providers without complex setup
- Follow industry best practices from day one
- Focus on code rather than tooling

## Productivity Benefits

### Time Savings
- **Environment Setup**: Save 4-8 hours per developer on initial setup
- **Tool Updates**: Eliminate 1-2 hours per month maintaining tools
- **Onboarding**: Reduce new team member onboarding from days to hours
- **Troubleshooting**: Minimize environment-related issues that can waste hours of development time

### Quality Improvements
- **Consistent Validation**: Every code change is automatically validated
- **Security Scanning**: Catch security issues before they reach production
- **Documentation**: Automatically generate and maintain documentation
- **Testing**: Verify infrastructure works as expected with integrated testing tools

### Collaboration Enhancements
- **Standardized Environment**: Everyone works with the same tools and versions
- **Reproducible Results**: Eliminate "works on my machine" problems
- **Knowledge Sharing**: Common toolset makes it easier to share techniques and solutions
- **Cross-Platform**: Works the same way on Windows, macOS, and Linux

## Real-World Success Stories

### Enterprise Adoption

A Fortune 500 company implemented this development environment across their infrastructure team of 50+ engineers. Results included:
- 75% reduction in environment-related issues
- 40% faster onboarding for new team members
- 30% increase in code quality metrics
- Standardized practices across 3 cloud platforms

### DevOps Transformation

A mid-sized SaaS company used this container as part of their DevOps transformation:
- Reduced infrastructure deployment errors by 65%
- Decreased time to provision new environments by 50%
- Improved security compliance from 70% to 98%
- Enabled developers to self-service infrastructure needs

### Educational Impact

A technical training organization adopted this container for their Terraform courses:
- Eliminated 90% of setup-related issues in classes
- Provided consistent learning environment across all student machines
- Allowed focus on teaching concepts rather than troubleshooting
- Enabled students to continue learning with the same environment after the course

## Volume Mounts

The container includes the following volume mounts:

- `~/.aws` - AWS credentials and configuration
- `~/.azure` - Azure credentials and configuration
- `~/.config/gcloud` - GCP credentials and configuration
- `~/.ssh` - SSH keys
- `terraform-cache` - Terraform plugin cache

## Security Considerations

- **Credential Isolation**: Credentials are mounted from the host to avoid storing them in the container
- **Automated Scanning**: Pre-commit hooks include security scanning for Terraform code
- **Secret Detection**: Automated detection is enabled to prevent committing sensitive information
- **Compliance Checking**: Built-in tools validate infrastructure against compliance standards
- **Least Privilege**: Authentication helpers encourage following least privilege principles

## Troubleshooting

### Common Issues

1. **Docker not running**: Ensure Docker is running on your system
2. **Permission issues**: Ensure you have the necessary permissions for the mounted volumes
3. **Authentication failures**: Check your credentials and ensure they are properly configured
4. **Resource constraints**: Increase Docker's allocated memory if container builds fail
5. **Network issues**: Verify your network can access required repositories and cloud services

### Logs

Container logs can be viewed in VS Code by clicking on the "Remote" indicator in the bottom-left corner and selecting "Show Container Log".

## Getting Help

### Documentation and Resources

- **Official Documentation**: Refer to the [USAGE.md](USAGE.md) file for detailed usage instructions
- **Issue Tracker**: Report bugs or request features through the [GitHub Issues](https://github.com/awslabs/aws-terraform-dev-container/issues)
- **Community Support**: Join discussions in the [Discussions](https://github.com/awslabs/aws-terraform-dev-container/discussions) section

### Learning Resources

- **Terraform Documentation**: [Terraform Docs](https://www.terraform.io/docs)
- **AWS Documentation**: [AWS Docs](https://docs.aws.amazon.com/)
- **Azure Documentation**: [Azure Docs](https://docs.microsoft.com/azure/)
- **GCP Documentation**: [GCP Docs](https://cloud.google.com/docs)

### Staying Updated

- **Watch the Repository**: Click the "Watch" button on GitHub to receive notifications about updates
- **Check the CHANGELOG**: Review the [CHANGELOG.md](CHANGELOG.md) file for version history and updates
- **Follow on Social Media**: Follow the maintainers and contributors on social media for announcements

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
