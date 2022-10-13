# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

.PHONY: tflint/init
## Init AWS TFLINT
tflint/init:
ifeq ($(wildcard $(WORKSPACE)/.tflint.hcl),)
	@cp $(HOME)/.tflint.hcl $(WORKSPACE)/.tflint.hcl
	@tflint --init
endif

.PHONY: tflint/version
## Display TFLINT version
tflint/version:
	@echo "--- TFLINT ---"
	@tflint --version
