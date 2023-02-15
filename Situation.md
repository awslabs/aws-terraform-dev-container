# Situation
## 1. Install

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

## 2. [Let's code!](main.tf)

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

## 3. What's wrong?

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
