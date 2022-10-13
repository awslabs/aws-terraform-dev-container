# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

.PHONY: gitignore/init
## Create a .gitignore file with most common rules
gitignore/init:
ifeq ($(wildcard $(WORKSPACE)/.gitignore),)
	curl -sL https://www.toptal.com/developers/gitignore/api/macos,windows,linux,terraform,visualstudiocode > $(WORKSPACE)/.gitignore
endif
