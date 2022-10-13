# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

SHELL = /bin/bash

export SELF ?= $(MAKE)
export PWD = $(shell pwd)

.PHONY: help
help: help/clean
	@exit 0

.PHONY: versions
versions: \
	aws/cli-version \
	checkov/version \
	go/version \
	gomplate/version \
	pre-commit/version \
	python/version \
	terraform/version \
	terraform-docs/version \
	terrascan/version \
	tflint/version \
	tfsec/version \
	tfswitch/version

.PHONY: init
## Initialize project with default configuration
init: pre-commit/init gitignore/init doc/init terraform-docs/init tflint/init
	@clear && printf "\e[0;32mAWS Terraform Dev Container: $(shell basename $(CURDIR))\e[0m\n"
