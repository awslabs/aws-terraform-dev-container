ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install OS packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    make

USER vscode

ARG TERRAFORM_DOCS_VERSION=0.16.0
ARG TFSEC_VERSION=1.15.2
ARG TERRASCAN_VERSION=1.13.2
ARG TFLINT_AWS_RULESET_VERSION=0.21.1

RUN cd /tmp/ \
    && git clone https://github.com/awslabs/aws-code-habits.git \
    && cd aws-code-habits \
    && make devcontainer/terraform/init \
    && rm -rf /tmp/aws-code-habits

USER root

COPY post-start.sh /usr/local/bin/post-start
RUN chmod +x /usr/local/bin/post-start
