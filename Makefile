# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

export WORKSPACE=$(shell pwd)
export HABITS = $(WORKSPACE)/habits

include $(WORKSPACE)/tools.env
# include $(WORKSPACE)/dev.env
# include $(WORKSPACE)/dev.secrets.env # remember to add *.secrets.env to .gitignore

include $(HABITS)/lib/make/Makefile
include $(HABITS)/lib/make/*/Makefile
