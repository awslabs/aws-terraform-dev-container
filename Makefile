# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

export WORKSPACE=$(shell pwd)
export HABITS = $(WORKSPACE)/habits

include $(WORKSPACE)/tools.env
# include $(WORKSPACE)/dev.env
# include $(WORKSPACE)/dev.secrets.env # remember to add *.secrets.env to .gitignore

include $(HABITS)/lib/make/Makefile
include $(HABITS)/lib/make/*/Makefile

.PHONY: docs
docs: terraform-docs/build doc/build

.PHONY: plan
## Performs code and doc hygiene, then a terraform plan
plan: docs pre-commit/run terraform/plan

.PHONY: apply
## Performs code and doc hygiene, terraform plan and then terraform apply
apply: plan
