# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

export README_INCLUDES ?= $(file://$(shell pwd)/?type=text/plain)

export README_TEMPLATE_YAML  ?= .devcontainer/files/README.yaml
export README_TEMPLATE_TMPL  ?= .devcontainer/files/README.tmpl

export README_YAML ?= doc/README.yaml
export README_TMPL ?= doc/README.tmpl

.PHONY: doc/init
## Initialize project's documentation
doc/init:
ifneq ($(wildcard doc/.*),)
	@echo "Found doc/"
else
	@echo "Did not find doc/"
	@mkdir -p doc
	@echo "Directory 'doc/' created"
endif
ifeq ("$(wildcard $(README_YAML))","")
	@echo "Copying $(README_TEMPLATE_YAML) to $(README_YAML)"
	@cp $(README_TEMPLATE_YAML) $(README_YAML)
endif
ifeq ("$(wildcard $(README_TMPL))","")
	@echo "Copying $(README_TEMPLATE_TMPL) to $(README_TMPL)"
	@cp $(README_TEMPLATE_TMPL) $(README_TMPL)
endif


.PHONY: doc/build
## Build README.md based on doc/README.yaml (and/or doc/.terraform-docs.yml)
doc/build: terraform-docs/build
	@echo "Using readme config $(README_YAML) to generate README.md"
	@gomplate --file $(README_TMPL) --out README.md
	@echo "Generated README.md from $(README_TMPL) using data from $(README_YAML)"
