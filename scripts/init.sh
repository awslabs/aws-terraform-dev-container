#!/usr/bin/env bash

set -e
set -u
set -o pipefail

git clone --branch=main --depth=1 https://github.com/awslabs/aws-terraform-dev-container.git
mv aws-terraform-dev-container/.devcontainer .devcontainer
rm -rf aws-terraform-dev-container

# Install AWS Code Habits | https://github.com/awslabs/aws-code-habits
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git submodule add --name habits -b main https://github.com/awslabs/aws-code-habits.git habits
else
  echo "Not inside a git repository — installing aws-code-habits as a plain clone."
  git clone --branch=main --depth=1 https://github.com/awslabs/aws-code-habits.git habits
fi
cp habits/scripts/Makefile Makefile
