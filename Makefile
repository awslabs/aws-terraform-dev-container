# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

export WORKSPACE=$(shell pwd)

include $(WORKSPACE)/.devcontainer/lib/make/Makefile
include $(WORKSPACE)/.devcontainer/lib/make/*/Makefile

.PHONY: plan
## Performs code and doc hygiene, then a terraform plan
plan: docs pre-commit/run terraform/plan

.PHONY: apply
## Performs code and doc hygiene, terraform plan and then terraform apply
apply: plan

.PHONY: docs
docs: terraform-docs/init terraform-docs/build doc/build
