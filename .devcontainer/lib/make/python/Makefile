# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

.PHONY: python/install
## Install Python 3
python/install:
	sudo apt-get -qq install --no-install-recommends --yes python3

.PHONY: python/pip-install
## Install Python 3 Pip
python/pip-install: python/install
	sudo apt-get -qq install --no-install-recommends --yes python3-pip
	pip3 install --user --upgrade pip

.PHONY: python/virtualenv-install
## Install Python 3 virtualenv
python/virtualenv: python/install
	sudo apt-get -qq install --no-install-recommends --yes python3-venv python3.8-venv

.PHONY: python/virtualenv-create
## Create a Python 3 virtualenv in the current directory
python/virtualenv-create:
	python3 -m venv .venv


.PHONY: python/version
## Display Python & Pip version
python/version:
	@echo "--- PYTHON 3 ---"
	@python3 --version
	@echo "--- PIP ---"
	@pip3 --version
