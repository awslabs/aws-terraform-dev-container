# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

export WORKSPACE=$(shell pwd)
export LIB = $(WORKSPACE)/.devcontainer/lib

include $(LIB)/make/Makefile
include $(LIB)/make/*/Makefile
