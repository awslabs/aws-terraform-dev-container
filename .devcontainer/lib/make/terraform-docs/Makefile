# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

export TERRAFORM_DOCS_TEMPLATE_YAML ?= $(WORKSPACE)/.devcontainer/files/.terraform-docs.yaml
export TERRAFORM_DOCS_YAML ?= $(WORKSPACE)/doc/.terraform-docs.yaml
export TERRAFORM_DOCS_OUTPUT ?= $(WORKSPACE)/doc/terraform-docs.md

.PHONY: terraform-docs/init
## Create initl configuration
terraform-docs/init:
ifneq ($(wildcard *.tf),)
	@cp $(TERRAFORM_DOCS_TEMPLATE_YAML) $(TERRAFORM_DOCS_YAML)
endif

.PHONY: terraform-docs/build
## Build doc/terraform-docs.md with Terraform Docs
terraform-docs/build:
ifneq ($(wildcard *.tf),)
	@echo "# Terraform" > Terraform.md
	@terraform-docs --config $(TERRAFORM_DOCS_YAML) . >> Terraform.md
endif

.PHONY: terraform-docs/version
## Display Terraform Docs version
terraform-docs/version:
	@echo "--- TERRAFORM DOCS ---"
	@terraform-docs --version
