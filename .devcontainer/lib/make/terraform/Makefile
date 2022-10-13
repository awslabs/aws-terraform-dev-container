# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

.PHONY: terraform/init
## Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
terraform/init: tfswitch/run terraform/fmt tflint/run
	terraform init

.PHONY: terraform/init/backend
## Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
terraform/init/backend: tfswitch/run terraform/fmt
	terraform init -backend-config="backend.hcl"

.PHONY: terraform/fmt
## Check if the input is formatted. Exit status will be 0 if all input is properly formatted and non-zero otherwise.
terraform/fmt:
	terraform fmt
	terraform fmt -check=true

.PHONY: terraform/validate
## Validate the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc.
terraform/validate:
	terraform validate

.PHONY: terraform/plan
## Generates an execution plan for Terraform
terraform/plan: tfswitch/run terraform/fmt terraform/validate
	terraform plan

.PHONY: terraform/apply
## Builds or changes infrastructure according to Terraform configuration files in DIR
terraform/apply: tfswitch/run terraform/fmt terraform/validate
	terraform apply -auto-approve

.PHONY: terraform/destroy
## Destroy Terraform-managed infrastructure.
terraform/destroy: tfswitch/run terraform/fmt terraform/validate
	terraform destroy -auto-approve

.PHONY: terraform/clean
## Remove temporary files and directories
terraform/clean:
	rm -rf .terraform
	rm -f .terraform.lock.hcl
	rm -f *.tfstate*
	rm -f *.tar.gz
	rm -f *.log

.PHONY: terraform/version
## Display Terraform version
terraform/version:
	@echo "--- TERRAFORM ---"
	@terraform --version
