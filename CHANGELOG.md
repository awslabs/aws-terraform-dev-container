# Changelog

All notable changes to the Terraform Development Environment will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.3] - 2025-06-11

### Added

- Added terratest v0.49.0 for infrastructure testing

### Changed

- Updated tool versions:
  - Terraform CLI from v1.5.7 to v1.12.1
  - AWS CLI from v2 to v2.27.26
  - terraform-docs from v0.16.0 to v0.20.0
  - tflint from v0.47.0 to v0.48.0
  - tfsec from v1.28.0 to v1.28.13
  - terrascan from v1.18.3 to v1.19.9
  - terragrunt from v0.48.0 to v0.50.1
  - infracost from v0.10.28 to v0.10.41
  - checkov from v2.3.360 to v3.2.439

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
