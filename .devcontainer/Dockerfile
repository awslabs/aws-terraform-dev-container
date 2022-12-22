# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.234.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ARG TARGETARCH

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
# hashicorp only provides amd64 packages, so we have to make do
ARG TERRAFORM_VERSION=1.3.6
RUN mkdir -p /tmp/download \
	&& cd /tmp/download \
	&& wget -O terraform.zip "https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_${TARGETARCH}.zip" \
	&& unzip -qq ./terraform.zip \
	&& mv ./terraform /usr/local/bin/terraform \
	&& rm -rf /tmp/download

# AWS CLI
SHELL ["/bin/zsh", "-c"]
RUN mkdir -p /tmp/download \
	&& cd /tmp/download \
	&& ARCH=${TARGETARCH/amd64/x86_64} \
	&& ARCH=${ARCH/arm64/aarch64} \
	&& wget -O awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip" \
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
	&& wget -O /tmp/download/gomplate "https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-${TARGETARCH}-slim" \
	&& chmod +x /tmp/download/gomplate \
	&& mv /tmp/download/gomplate /usr/local/bin/ \
	&& rm -rf /tmp/download

# Terraform Docs
ARG TERRAFORM_DOCS_VERSION=0.16.0
RUN mkdir -p /tmp/download /tmp/extract \
	&& wget -O /tmp/download/terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${TARGETARCH}.tar.gz" \
	&& tar -C /tmp/extract -xzf /tmp/download/terraform-docs.tar.gz \
	&& mv /tmp/extract/terraform-docs /usr/local/bin/ \
	&& rm -rf /tmp/download /tmp/extract

# TFLINT
ARG TFLINT_AWS_RULESET_VERSION=0.13.4
RUN curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# TFSEC
ARG TFSEC_VERSION=1.15.2
RUN mkdir -p /tmp/download \
	&& wget -O /tmp/download/tfsec "https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-${TARGETARCH}" \
	&& chmod +x /tmp/download/tfsec \
	&& mv /tmp/download/tfsec /usr/local/bin/ \
	&& rm -rf /tmp/download

# TFSWITCH
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

# TERRASCAN
ARG TERRASCAN_VERSION=1.13.2
RUN mkdir -p /tmp/download /tmp/extract \
	&& ARCH=${TARGETARCH/amd64/x86_64} \
	&& wget -O /tmp/download/terrascan "https://github.com/tenable/terrascan/releases/download/v${TERRASCAN_VERSION}/terrascan_${TERRASCAN_VERSION}_Linux_${ARCH}.tar.gz" \
	&& sha256sum /tmp/download/terrascan \
	&& tar -C /tmp/extract -xzf /tmp/download/terrascan \
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

# Install Ansible
RUN pip3 install --progress-bar off --upgrade --user ansible

USER root

COPY post-start.sh /usr/local/bin/post-start
RUN chmod +x /usr/local/bin/post-start
