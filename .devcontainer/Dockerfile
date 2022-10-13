# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.234.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install OS packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
	curl \
	expect \
	figlet \
	gawk \
	git \
	git-flow \
	golang \
	gnupg \
	jq \
	less \
	make \
	python3-pip \
	software-properties-common \
	ssh \
	tree \
	bash-completion \
	unzip \
	vim \
	wget \
	&& rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

# Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
	&& apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
	&& apt-get update && sudo apt-get -qq install --no-install-recommends --yes terraform terraform-ls

# AWS CLI
SHELL ["/bin/zsh", "-c"]
RUN mkdir -p /tmp/download \
	&& cd /tmp/download \
	&& curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" --silent -o "awscliv2.zip" \
	&& unzip -qq awscliv2.zip \
	&& ./aws/install \
	&& rm -rf /tmp/download \
	&& autoload bashcompinit && bashcompinit \
	&& autoload -Uz compinit && compinit \
	&& echo "complete -C '/usr/local/bin/aws_completer' aws" >> /home/vscode/.bashrc \
	&& echo "complete -C '/usr/local/bin/aws_completer' aws" >> /home/vscode/.zshrc

# Gomplate
ARG GOMPLATE_VERSION=3.10.0
RUN mkdir -p /tmp/download \
	&& wget https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64-slim -O /tmp/download/gomplate --quiet --no-check-certificate \
	&& chmod +x /tmp/download/gomplate \
	&& mv /tmp/download/gomplate /usr/local/bin/ \
	&& rm -rf /tmp/download

# Terraform Docs
ARG TERRAFORM_DOCS_VERSION=0.16.0
RUN mkdir -p /tmp/download /tmp/extract \
	&& wget https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz -O /tmp/download/terraform-docs-${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz --quiet --no-check-certificate \
	&& tar -C /tmp/extract -xzf /tmp/download/terraform-docs-${TERRAFORM_DOCS_VERSION}-linux-amd64.tar.gz \
	&& mv /tmp/extract/terraform-docs /usr/local/bin/ \
	&& rm -rf /tmp/download /tmp/extract

# TFLINT
ARG TFLINT_AWS_RULESET_VERSION=0.13.4
RUN curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

COPY files/.tflint.hcl /home/vscode/.tflint.hcl
RUN sed -i "s,TFLINT_AWS_RULESET_VERSION,${TFLINT_AWS_RULESET_VERSION},g" /home/vscode/.tflint.hcl

# TFSEC
ARG TFSEC_VERSION=1.15.2
RUN mkdir -p /tmp/download \
	&& wget https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 -O /tmp/download/tfsec --quiet --no-check-certificate \
	&& chmod +x /tmp/download/tfsec \
	&& mv /tmp/download/tfsec /usr/local/bin/ \
	&& rm -rf /tmp/download

# TFSWITCH
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

# TERRASCAN
ARG TERRASCAN_VERSION=1.13.2
RUN mkdir -p /tmp/download /tmp/extract \
	&& wget https://github.com/accurics/terrascan/releases/download/v${TERRASCAN_VERSION}/terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz -O /tmp/download/terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz --quiet --no-check-certificate \
	&& sha256sum /tmp/download/terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz \
	&& tar -C /tmp/extract -xzf /tmp/download/terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz \
	&& sudo mv /tmp/extract/terrascan /usr/local/bin/ \
	&& rm -rf /tmp/download /tmp/extract

# Gitignore CLI
RUN echo "function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/\$@ ;}" >> /home/vscode/.bashrc
RUN echo "function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/\$@ ;}" >> /home/vscode/.zshrc

# Upgrade pip
RUN pip3 install --progress-bar off --upgrade pip

USER vscode

# Install pre-commit
RUN pip3 install --progress-bar off --upgrade --user pre-commit

# Install checkov
RUN pip3 install --progress-bar off --upgrade --user checkov

# Initialize TFLINT rules set
# RUN tflint --init

USER root

COPY post-start.sh /usr/local/bin/post-start
RUN chmod +x /usr/local/bin/post-start
