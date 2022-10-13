#!/usr/bin/env bash

# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# copy Makefile to current workspace, only if doesn't exist
if [ ! -f Makefile ]; then
    cp .devcontainer/Makefile ./
fi

make init
