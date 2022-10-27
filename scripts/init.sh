#!/usr/bin/env bash

set -e
set -u
set -o pipefail

git clone --branch=main --depth=1 git@github.com:awslabs/aws-terraform-dev-container.git
mv aws-terraform-dev-container/.devcontainer .devcontainer
rm -rf aws-terraform-dev-container

# Install AWS Code Habits | https://github.com/awslabs/aws-code-habits
curl -sL https://raw.githubusercontent.com/awslabs/aws-code-habits/main/scripts/remote/init.sh | bash