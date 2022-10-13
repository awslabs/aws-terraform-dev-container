# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

.PHONY: pre-commit/install
## Install pre-commit using Pip3
pre-commit/install: python/pip-install
	pip3 install --user pre-commit

.PHONY: pre-commit/install-hooks
## Install pre-commit hooks
pre-commit/install-hooks: python/pip-install pre-commit/install
	pre-commit install

.PHONY: pre-commit/init
pre-commit/init:
## Create initial configuration
ifeq ($(wildcard $(WORKSPACE)/.pre-commit-config.yaml),)
	cp .devcontainer/files/.pre-commit-config.yaml ./
endif

.PHONY: pre-commit/update
##  Update pre-commit-config.yml with the latest version
pre-commit/update:
	pre-commit autoupdate

.PHONY: pre-commit/run
## Execute pre-commit hooks on all files
pre-commit/run:
	pre-commit run --all-files

.PHONY: pre-commit/version
## Display pre-commit version
pre-commit/version:
	@echo "--- PRE-COMMIT ---"
	@pre-commit --version
