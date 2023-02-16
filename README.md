# BuildOnAWS

## Problem

### 1. Install
<details>

```bash
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
sudo apt-get update && sudo apt install -y gnupg software-properties-common
# https://www.hashicorp.com/official-packaging-guide
sudo apt update && sudo apt install -y gpg
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
# must match "798A EC65 4E5C 1542 8C8E 42EE AA16 FCBC A621 E701"
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
# add the HashiCorp repo
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# install terraform
sudo apt update && sudo apt install -y terraform
terraform --version
# install autocomplete, need to restart
terraform -install-autocomplete
```
</details>

### 2. [Let's code!](main.tf)
<details>

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
# optional
# terraform show
# terraform state list
terraform destroy
# clean up
rm -rf .terraform.lock.hcl terraform.tfstate* .terraform
```
</details>

### 3. What's wrong?
<details>

What if:
- people work on different OSes
    - installation varies
- terraform or 3rd party tools not installed
    - lint, documentation, static code analysis, and more
    - versions do not match
- commands are not executed consistently
- what about hygiene?
    - common `.pre-commit-config.yaml`, `.gitignore`, and more

How can we provide our developers a common environment?
</details>

## Solution

[AWS Terraform Dev Container](https://github.com/awslabs/aws-terraform-dev-container)

### Prerequisites
<details>

A list of things you need, or how to install them.

- [Visual Studio Code](https://code.visualstudio.com/) - Visual Studio Code is a code editor redefined and optimized for building and debugging modern web and cloud applications.
- [VSCode Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) - An extension pack that lets you open any folder in a container, on a remote machine, or in WSL and take advantage of VS Code's full feature set.
- [Docker](https://www.docker.com/products/docker-desktop/) - The fastest way to containerize applications

- (Windows) [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) - Developers can access the power of both Windows and Linux at the same time on a Windows machine.

</details>

### Developing inside a container
<details>

https://code.visualstudio.com/docs/devcontainers/containers
![architecture](https://code.visualstudio.com/assets/docs/devcontainers/containers/architecture-containers.png)

</details>

### Getting started
<details>

Automatically:
```bash
curl -sL https://raw.githubusercontent.com/awslabs/aws-terraform-dev-container/main/scripts/init.sh | bash
```

Or manually:
```bash
git clone --branch=main --depth=1 git@github.com:awslabs/aws-terraform-dev-container.git
mv aws-terraform-dev-container/.devcontainer .devcontainer
rm -rf aws-terraform-dev-container

# Install AWS Code Habits | https://github.com/awslabs/aws-code-habits
git submodule add --name habits -b main https://github.com/awslabs/aws-code-habits.git habits
cp habits/scripts/Makefile Makefile
```

Let's have a quick look on:
* [devcontainer.json](.devcontainer/devcontainer.json)
* [Dockerfile](.devcontainer/Dockerfile)
* [AWS Code Habits](habits)
* [Makefile](Makefile)

Let's (re)build our container!

</details>

### What about the problems we discussed earlier?
<details>

What if:

> people work on different OSes?

Ubuntu.

> installation varies

```bash
make terraform/install
```

[habits/lib/make/terraform/Makefile](habits/lib/make/terraform/Makefile#L4)

> terraform or 3rd party tool versions do not match?

Tooling is part of version control now:
```
"TERRAFORM_DOCS_VERSION": "0.16.0",
"TFSEC_VERSION": "1.28.0",
"TERRASCAN_VERSION": "1.15.2",
"TFLINT_AWS_RULESET_VERSION": "0.21.1"
```

> commands are not executed consistently?

```bash
make help
```

> not all 3rd party tools available?

Part of the [Docker image build process](.devcontainer/Dockerfile#L19).
```bash
make devcontainer/terraform/init
```
[habits/lib/make/devcontainer/Makefile](habits/lib/make/devcontainer/Makefile#L11)

> lint

```bash
make tflint/init
```

> documentation

```bash
make terraform-docs/build
```

> pre-commit-config

```bash
make terraform/pre-commit/init
# optional
make pre-commit/update
make pre-commit/run
```

> .gitignore

```bash
make terraform/gitignore/init
```

> static code analysis

```bash
make tfsec/run
```

Use the `Habits` library:

```
make terraform/plan
```

Or create your own [make rules](Makefile)

```bash
.PHONY: init
init: tflint/init terraform/pre-commit/init terraform/gitignore/init

.PHONY: plan
plan: terraform-docs/build pre-commit/run
	terraform plan -out tf.plan
	terraform show -json tf.plan  > tf.json

.PHONY: apply
apply: plan
	terraform apply -auto-approve tf.plan
```

</details>

### There is an issue with the latest version!
<details>

We are running the latest version of terraform
```bash
terraform --version
Terraform v1.3.8
on linux_amd64
```

Need to uninstall the latest version of Terraform, pin the exact version `= 1.2.0` and let `tfswitch` manage our version for us

```bash
sudo apt remove terraform
# modify main.tf, required_version = "= 1.2.0"
source ~/.profile # vscode server doesn't use the login shell automatically
# tfswtich downloads and keep the tf version under ~/bin
```

Run `make apply` again now! Issue gone!
</details>