## Make

```
Available targets:

  aws/cfn-lint/install                Install AWS CloudFormation Linter
  aws/cli/install                     Install AWS Command Line Interface v2
  aws/cli/version                     Display AWS CLI version
  aws/cloudformation/create-change-set Creates a list of changes that will be applied to a stack so that you can review the changes before executing them.
  aws/cloudformation/create-change-set-without-parameters Creates a list of changes that will be applied to a stack so that you can review the changes before executing them.
  aws/cloudformation/create-folder-structure Create a folder structure for CloudFormation projects
  aws/cloudformation/create-parameters Copy a CloudFormation parameters to be used as example
  aws/cloudformation/create-project   Create a CloudFormation project structure
  aws/cloudformation/create/service-linked-role Creates  an  IAM  role that is linked to a specific Amazon Elasticsearch service.
  aws/cloudformation/create-stack     Creates a stack as specified in the template.
  aws/cloudformation/create-stack-without-parameters Creates a stack as specified in the template. (don't pass --parameters flag)
  aws/cloudformation/create-template-yaml Copy a CloudFormation template to be used as example
  aws/cloudformation/delete-change-set Delete latest change-set created
  aws/cloudformation/delete/service-linked-role Deletes  an  IAM  role that is linked to a specific Amazon Web Services service.
  aws/cloudformation/delete-stack     Delete CloudFormation Stack
  aws/cloudformation/describe-stack-events Returns  all  stack  related  events  for  a specified stack in reverse chronological order.
  aws/cloudformation/describe-stack   Returns  the  description for the specified stack; if no stack name was specified, then it returns the description for all the stacks created.
  aws/cloudformation/detect-stack-drift Detects  whether a stack's actual configuration differs, or has drifted , from it's expected configuration, as defined in  the  stack  template and  any  values specified as template parameters.
  aws/cloudformation/estimate-template-cost Returns  the  estimated monthly cost of a template
  aws/cloudformation/execute-change-set Execute latest change-set
  aws/cloudformation/hygiene          Execute CFN Lint and pre-commit rules
  aws/cloudformation/latest-change-set Display latest change-set
  aws/codeartifact/login              Login into AWS CodeArtifact
  aws/ssm/install-plugin              Install AWS SSM plugin
  aws/ssm/start-session               Start session with AWS Systems Manager Session Manager
  aws/sso/login                       Login into AWS account and export credentials to ~/.aws/credentials
  aws/sts/get-caller-identity         Returns  details  about the IAM user or role whose credentials are used to call the operation.
  checkov/run                         Run Checkov
  checkov/version                     Display checkov version
  doc/build                           Builds documentation
  doc/init                            Initialize documentation
  docker/prune                        Remove unused images and all stopped containers
  docker/remove-containers            Remove all Docker containers
  docker/remove-images                Remove all Docker images
  docker/remove-volumes               Remove all Docker volumes
  git/config/init                     Initialize git configuration for project
  github/actions/init                 Initialize .github/actions directory
  github/issues/init                  Initialize .github/issues directory
  github/pull-request/init            Initialize .github/pull-request directory
  github/workflows/init               Initialize .github/workflows directory
  gitignore/init                      Create .gitignore file
  gitignore/install                   Install gitignore
  gitignore/list                      List all gitignore templates
  go/install                          Install Golang
  gomplate/version                    Display Gomplate version
  go/version                          Display Go version
  habits/check                        Performs checks
  habits/init                         Initialize gitignore, documentation, pre-commit, github workflows, issues and pull-request
  habits/install                      Install Habits dependencies
  habits/remove                       Uninstall Habits
  habits/update                       Update Habits
  help/clean                          Help screen
  nodejs/install                      Install NodeJS
  npm/install                         Install NPM
  pre-commit/hooks/install            Install pre-commit hooks
  pre-commit/init                     Initialize .pre-commit-config.yaml to working directoy
  pre-commit/install                  Install pre-commit using Pip3
  pre-commit/remove                   Remove .pre-commit-config.yaml
  pre-commit/run                      Execute pre-commit hooks on all files
  pre-commit/update                   Update pre-commit-config.yaml with the latest version
  pre-commit/version                  Display pre-commit version
  python/install                      Install Python 3
  python/pip/install                  Install Python 3 Pip
  python/version                      Display Python & Pip version
  python/virtualenv/init              Initialize a Python 3 virtualenv in the current directory
  python/virtualenv/install           Install Python 3 virtualenv
  python/virtualenv/remove            Remove Python 3 virtualenv in the current directory
  terraform/apply                     Builds or changes infrastructure according to Terraform configuration files in DIR
  terraform/clean                     Remove temporary files and directories
  terraform/destroy                   Destroy Terraform-managed infrastructure.
  terraform-docs/build                Build doc/terraform-docs.md with Terraform Docs
  terraform-docs/version              Display Terraform Docs version
  terraform/fmt                       Check if the input is formatted. Exit status will be 0 if all input is properly formatted and non-zero otherwise.
  terraform/init/backend              Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
  terraform/init                      Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
  terraform/install                   Install Terraform latest version
  terraform/plan                      Generates an execution plan for Terraform
  terraform/validate                  Validate the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc.
  terraform/version                   Display Terraform version
  terrascan/run                       Run Terrascan
  terrascan/version                   Display Terrascan version
  tflint/init/force                   Init AWS TFLINT, overwrite current configuration
  tflint/init                         Init AWS TFLINT
  tflint/run                          Run TFLINT
  tflint/version                      Display TFLINT version
  tfsec/run                           Run TFSEC
  tfsec/version                       Display TFSEC version
  tfswitch/run                        Execute tfswitch
  tfswitch/version                    Display tfswitch version
  ubuntu/install                      Install most common packages
  ubuntu/update                       Update and upgrade Ubuntu packages

```
