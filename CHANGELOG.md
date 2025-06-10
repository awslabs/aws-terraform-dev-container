# Changelog

All notable changes to the Terraform Development Environment will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.2] - 2025-06-10

### Added

- Initial release of the Terraform Development Environment
- Multi-cloud support for AWS, Azure, and GCP
- Terraform CLI v1.5.7
- Supporting tools:
  - terraform-docs v0.16.0
  - tflint v0.47.0 with AWS, Azure, and GCP rulesets
  - tfsec v1.28.0
  - terrascan v1.18.3
  - terragrunt v0.48.0
  - infracost v0.10.28
  - checkov v2.3.360
- Cloud provider CLIs:
  - AWS CLI v2
  - Azure CLI
  - Google Cloud SDK
- Authentication helper scripts for AWS, Azure, and GCP
- Pre-commit hooks for Terraform validation, formatting, and security scanning
- VS Code tasks for common Terraform operations
- VS Code settings and extensions for Terraform development
- Persistent volume mounts for credentials and caching
- Comprehensive documentation in README.md and USAGE.md

### Changed

- Updated from the base AWS Terraform Dev Container
- Enhanced Dockerfile with modular installation scripts
- Improved pre-commit configuration with additional hooks
- Extended VS Code tasks and settings

### Fixed

- Path issues in post-start script
- Permission issues with credential directories
- TFLint configuration for multi-cloud support
