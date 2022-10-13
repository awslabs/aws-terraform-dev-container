## Make

```
Available targets:

  aws/cli-version                     Display AWS CLI version
  checkov/run                         Run Checkov
  checkov/version                     Display checkov version
  doc/build                           Build README.md based on doc/README.yaml (and/or doc/.terraform-docs.yml)
  doc/init                            Initialize project's documentation
  gitignore/init                      Copy .gitignore to working directoy
  go/install                          Install Golang
  gomplate/version                    Display Gomplate version
  go/version                          Display Go version
  help/clean                          Help screen
  pre-commit/copy                     Copy .pre-commit-config.yaml to working directoy
  pre-commit/install-hooks            Install pre-commit hooks
  pre-commit/install                  Install pre-commit using Pip3
  pre-commit/run                      Execute pre-commit hooks on all files
  pre-commit/update                    Update pre-commit-config.yml with the latest version
  pre-commit/version                  Display pre-commit version
  python/install                      Install Python 3
  python/pip-install                  Install Python 3 Pip
  python/version                      Display Python & Pip version
  python/virtualenv-create            Create a Python 3 virtualenv in the current directory
  python/virtualenv                   Install Python 3 virtualenv
  terraform/apply                     Builds or changes infrastructure according to Terraform configuration files in DIR
  terraform/clean                     Remove temporary files and directories
  terraform/destroy                   Destroy Terraform-managed infrastructure.
  terraform-docs/build                Build doc/terraform-docs.md with Terraform Docs
  terraform-docs/copy                 Copy .terraform-docs-config.yaml to working directoy
  terraform-docs/version              Display Terraform Docs version
  terraform/fmt                       Check if the input is formatted. Exit status will be 0 if all input is properly formatted and non-zero otherwise.
  terraform/init/backend              Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
  terraform/init                      Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
  terraform/plan                      Generates an execution plan for Terraform
  terraform/validate                  Validate the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc.
  terraform/version                   Display Terraform version
  terrascan/run                       Run Terrascan
  terrascan/version                   Display Terrascan version
  tflint/copy                         Copy .tflint.hcl to working directoy
  tflint/run                          Execute tflint
  tflint/version                      Display TFLINT version
  tfsec/run                           Run TFSEC
  tfsec/version                       Display TFSEC version
  tfswitch/run                        Execute tfswitch
  tfswitch/version                    Display tfswitch version

```