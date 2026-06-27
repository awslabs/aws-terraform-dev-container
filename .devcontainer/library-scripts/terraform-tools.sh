#!/usr/bin/env bash
set -euo pipefail

# This script installs Terraform and related tools.
#
# Hardening notes (2026-06):
#   Every binary download is checksum-verified. Where upstream publishes a
#   per-release checksum file (HashiCorp *_SHA256SUMS, GitHub release
#   `checksums.txt`, golang.org's dl JSON), we fetch that file at install
#   time and feed it to `sha256sum -c`. A few smaller tools that publish a
#   single per-asset `.sha256` file are handled the same way.
#
#   Trust model: we trust the TLS endpoint that serves the checksum file.
#   This matches the publisher's own documented verification path and is
#   strictly stronger than the previous "download blob, hope for the best"
#   posture. For HashiCorp tools an additional GPG verification of
#   *_SHA256SUMS.sig is possible but is intentionally out of scope here.
#
# Architecture support (2026-06):
#   The build host's architecture is detected once via `dpkg --print-architecture`
#   and every download URL / checksum lookup is constructed accordingly. This
#   lets the same Dockerfile build natively on amd64 (linux/amd64) and arm64
#   (linux/arm64, e.g. Apple Silicon) without producing a mixed-arch image.
DPKG_ARCH="$(dpkg --print-architecture)"
case "${DPKG_ARCH}" in
    amd64) ;;
    arm64) ;;
    *) echo "Unsupported architecture: ${DPKG_ARCH}" >&2; exit 1 ;;
esac

# Per-tool arch-name mappings. Most tools use the dpkg form (amd64 / arm64),
# Terrascan uses Linux_x86_64 vs Linux_arm64 (only the amd64 form differs).
TF_ARCH="${DPKG_ARCH}"               # terraform, tflint, terragrunt: linux_${TF_ARCH}
TFDOCS_ARCH="${DPKG_ARCH}"           # terraform-docs, infracost, tfsec, Go: linux-${TFDOCS_ARCH}
case "${DPKG_ARCH}" in
    amd64) TERRASCAN_ARCH="x86_64" ;;
    arm64) TERRASCAN_ARCH="arm64" ;;
esac

# Versions (do not change defaults — Dockerfile passes 12 positional args)
TERRAFORM_VERSION=${1:-"1.12.1"}
TERRAFORM_DOCS_VERSION=${2:-"0.20.0"}
TFSEC_VERSION=${3:-"1.28.13"}
TERRASCAN_VERSION=${4:-"1.19.9"}
TFLINT_VERSION=${5:-"0.48.0"}
TFLINT_AWS_RULESET_VERSION=${6:-"0.23.1"}
TFLINT_AZURE_RULESET_VERSION=${7:-"0.23.0"}
TFLINT_GCP_RULESET_VERSION=${8:-"0.23.1"}
TERRAGRUNT_VERSION=${9:-"0.50.1"}
TERRATEST_VERSION=${10:-"0.49.0"}
INFRACOST_VERSION=${11:-"0.10.41"}
CHECKOV_VERSION=${12:-"3.2.439"}

# Pinned Go version used to back terratest. SHA256s are from
# https://go.dev/dl/?mode=json&include=all (linux archive for each arch).
GO_VERSION="1.20.5"
GO_LINUX_AMD64_SHA256="d7ec48cde0d3d2be2c69203bc3e0a44de8660b9c09a6e85c4732a3f7dc442612"
GO_LINUX_ARM64_SHA256="aa2fab0a7da20213ff975fa7876a66d47b48351558d98851b87d1cfef4360d09"
case "${DPKG_ARCH}" in
    amd64) GO_SHA256="${GO_LINUX_AMD64_SHA256}" ;;
    arm64) GO_SHA256="${GO_LINUX_ARM64_SHA256}" ;;
esac

# Always clear the workspace tmp on exit so a partial download never lingers
cleanup() {
    rm -f \
        /tmp/terraform.zip /tmp/terraform_SHA256SUMS \
        /tmp/terraform-docs.tar.gz /tmp/terraform-docs.sha256sum \
        /tmp/tfsec /tmp/tfsec_checksums.txt \
        /tmp/terrascan.tar.gz /tmp/terrascan_checksums.txt \
        /tmp/tflint.zip /tmp/tflint_checksums.txt \
        /tmp/tflint-aws-ruleset.zip /tmp/tflint-aws-ruleset_checksums.txt \
        /tmp/tflint-azure-ruleset.zip /tmp/tflint-azure-ruleset_checksums.txt \
        /tmp/tflint-gcp-ruleset.zip /tmp/tflint-gcp-ruleset_checksums.txt \
        /tmp/terragrunt /tmp/terragrunt_SHA256SUMS \
        /tmp/infracost.tar.gz /tmp/infracost.tar.gz.sha256 \
        /tmp/go.tar.gz
}
trap cleanup EXIT

# verify_sha256 <file> <expected-sha256>
# Verifies that <file> hashes to <expected-sha256>. Exits non-zero on mismatch.
verify_sha256() {
    local file="$1"
    local expected="$2"
    echo "${expected}  ${file}" | sha256sum -c -
}

# verify_from_sums_file <file> <basename-in-sums> <sums-file>
# Looks up <basename-in-sums> inside <sums-file> and verifies <file> against it.
verify_from_sums_file() {
    local file="$1"
    local basename_in_sums="$2"
    local sums_file="$3"
    local expected
    expected="$(grep -E "[[:space:]]\\*?${basename_in_sums}\$" "${sums_file}" | awk '{print $1}' | head -n1)"
    if [[ -z "${expected}" ]]; then
        echo "ERROR: could not find checksum for ${basename_in_sums} in ${sums_file}" >&2
        return 1
    fi
    verify_sha256 "${file}" "${expected}"
}

echo "Installing Terraform v${TERRAFORM_VERSION}..."
curl -fsSL -o /tmp/terraform.zip \
    "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TF_ARCH}.zip"
curl -fsSL -o /tmp/terraform_SHA256SUMS \
    "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS"
verify_from_sums_file /tmp/terraform.zip \
    "terraform_${TERRAFORM_VERSION}_linux_${TF_ARCH}.zip" /tmp/terraform_SHA256SUMS
unzip -qq /tmp/terraform.zip -d /tmp
sudo mv /tmp/terraform /usr/local/bin/

echo "Installing terraform-docs v${TERRAFORM_DOCS_VERSION}..."
curl -fsSL -o /tmp/terraform-docs.tar.gz \
    "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${TFDOCS_ARCH}.tar.gz"
curl -fsSL -o /tmp/terraform-docs.sha256sum \
    "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}.sha256sum"
verify_from_sums_file /tmp/terraform-docs.tar.gz \
    "terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${TFDOCS_ARCH}.tar.gz" /tmp/terraform-docs.sha256sum
tar -xzf /tmp/terraform-docs.tar.gz -C /tmp
sudo mv /tmp/terraform-docs /usr/local/bin/

echo "Installing tfsec v${TFSEC_VERSION}..."
curl -fsSL -o /tmp/tfsec \
    "https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-${TFDOCS_ARCH}"
curl -fsSL -o /tmp/tfsec_checksums.txt \
    "https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec_checksums.txt"
verify_from_sums_file /tmp/tfsec "tfsec-linux-${TFDOCS_ARCH}" /tmp/tfsec_checksums.txt
sudo mv /tmp/tfsec /usr/local/bin/
sudo chmod +x /usr/local/bin/tfsec

echo "Installing terrascan v${TERRASCAN_VERSION}..."
curl -fsSL -o /tmp/terrascan.tar.gz \
    "https://github.com/tenable/terrascan/releases/download/v${TERRASCAN_VERSION}/terrascan_${TERRASCAN_VERSION}_Linux_${TERRASCAN_ARCH}.tar.gz"
curl -fsSL -o /tmp/terrascan_checksums.txt \
    "https://github.com/tenable/terrascan/releases/download/v${TERRASCAN_VERSION}/checksums.txt"
verify_from_sums_file /tmp/terrascan.tar.gz \
    "terrascan_${TERRASCAN_VERSION}_Linux_${TERRASCAN_ARCH}.tar.gz" /tmp/terrascan_checksums.txt
tar -xzf /tmp/terrascan.tar.gz -C /tmp
sudo mv /tmp/terrascan /usr/local/bin/

echo "Installing tflint v${TFLINT_VERSION}..."
curl -fsSL -o /tmp/tflint.zip \
    "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_${TF_ARCH}.zip"
curl -fsSL -o /tmp/tflint_checksums.txt \
    "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/checksums.txt"
verify_from_sums_file /tmp/tflint.zip "tflint_linux_${TF_ARCH}.zip" /tmp/tflint_checksums.txt
unzip -qq /tmp/tflint.zip -d /tmp
sudo mv /tmp/tflint /usr/local/bin/

echo "Installing TFLint AWS ruleset v${TFLINT_AWS_RULESET_VERSION}..."
mkdir -p ~/.tflint.d/plugins
curl -fsSL -o /tmp/tflint-aws-ruleset.zip \
    "https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v${TFLINT_AWS_RULESET_VERSION}/tflint-ruleset-aws_linux_${TF_ARCH}.zip"
curl -fsSL -o /tmp/tflint-aws-ruleset_checksums.txt \
    "https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v${TFLINT_AWS_RULESET_VERSION}/checksums.txt"
verify_from_sums_file /tmp/tflint-aws-ruleset.zip \
    "tflint-ruleset-aws_linux_${TF_ARCH}.zip" /tmp/tflint-aws-ruleset_checksums.txt
unzip -qq /tmp/tflint-aws-ruleset.zip -d ~/.tflint.d/plugins

echo "Installing TFLint Azure ruleset v${TFLINT_AZURE_RULESET_VERSION}..."
curl -fsSL -o /tmp/tflint-azure-ruleset.zip \
    "https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v${TFLINT_AZURE_RULESET_VERSION}/tflint-ruleset-azurerm_linux_${TF_ARCH}.zip"
curl -fsSL -o /tmp/tflint-azure-ruleset_checksums.txt \
    "https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v${TFLINT_AZURE_RULESET_VERSION}/checksums.txt"
verify_from_sums_file /tmp/tflint-azure-ruleset.zip \
    "tflint-ruleset-azurerm_linux_${TF_ARCH}.zip" /tmp/tflint-azure-ruleset_checksums.txt
unzip -qq /tmp/tflint-azure-ruleset.zip -d ~/.tflint.d/plugins

echo "Installing TFLint GCP ruleset v${TFLINT_GCP_RULESET_VERSION}..."
curl -fsSL -o /tmp/tflint-gcp-ruleset.zip \
    "https://github.com/terraform-linters/tflint-ruleset-google/releases/download/v${TFLINT_GCP_RULESET_VERSION}/tflint-ruleset-google_linux_${TF_ARCH}.zip"
curl -fsSL -o /tmp/tflint-gcp-ruleset_checksums.txt \
    "https://github.com/terraform-linters/tflint-ruleset-google/releases/download/v${TFLINT_GCP_RULESET_VERSION}/checksums.txt"
verify_from_sums_file /tmp/tflint-gcp-ruleset.zip \
    "tflint-ruleset-google_linux_${TF_ARCH}.zip" /tmp/tflint-gcp-ruleset_checksums.txt
unzip -qq /tmp/tflint-gcp-ruleset.zip -d ~/.tflint.d/plugins

echo "Installing Terragrunt v${TERRAGRUNT_VERSION}..."
curl -fsSL -o /tmp/terragrunt \
    "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_${TF_ARCH}"
curl -fsSL -o /tmp/terragrunt_SHA256SUMS \
    "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/SHA256SUMS"
verify_from_sums_file /tmp/terragrunt "terragrunt_linux_${TF_ARCH}" /tmp/terragrunt_SHA256SUMS
sudo mv /tmp/terragrunt /usr/local/bin/
sudo chmod +x /usr/local/bin/terragrunt

echo "Installing Terratest v${TERRATEST_VERSION}..."
# Terratest is a Go library, so we'll set an environment variable to track the version
echo "export TERRATEST_VERSION=${TERRATEST_VERSION}" >> /home/vscode/.bashrc

# Install Go if not already installed
if ! command -v go &> /dev/null; then
    echo "Installing Go v${GO_VERSION} (required for Terratest)..."
    curl -fsSL -o /tmp/go.tar.gz "https://golang.org/dl/go${GO_VERSION}.linux-${TFDOCS_ARCH}.tar.gz"
    verify_sha256 /tmp/go.tar.gz "${GO_SHA256}"
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    # Write $PATH/$HOME verbatim so they expand at shell startup, not now.
    # shellcheck disable=SC2016
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /home/vscode/.bashrc
    # shellcheck disable=SC2016
    echo 'export PATH=$PATH:$HOME/go/bin' >> /home/vscode/.bashrc
fi

# Create a simple wrapper script for terratest
cat > /tmp/terratest << EOF
#!/bin/bash
echo "Terratest v${TERRATEST_VERSION}"
echo "Terratest is a Go library for testing infrastructure code."
echo "To use Terratest, add it to your Go project:"
echo "go get github.com/gruntwork-io/terratest@v${TERRATEST_VERSION}"
EOF
sudo mv /tmp/terratest /usr/local/bin/
sudo chmod +x /usr/local/bin/terratest

echo "Installing Infracost v${INFRACOST_VERSION}..."
curl -fsSL -o /tmp/infracost.tar.gz \
    "https://github.com/infracost/infracost/releases/download/v${INFRACOST_VERSION}/infracost-linux-${TFDOCS_ARCH}.tar.gz"
curl -fsSL -o /tmp/infracost.tar.gz.sha256 \
    "https://github.com/infracost/infracost/releases/download/v${INFRACOST_VERSION}/infracost-linux-${TFDOCS_ARCH}.tar.gz.sha256"
# Infracost publishes a single-line per-asset .sha256 in `<sum>  <filename>` form.
verify_from_sums_file /tmp/infracost.tar.gz \
    "infracost-linux-${TFDOCS_ARCH}.tar.gz" /tmp/infracost.tar.gz.sha256
tar -xzf /tmp/infracost.tar.gz -C /tmp
sudo mv "/tmp/infracost-linux-${TFDOCS_ARCH}" /usr/local/bin/infracost

echo "Installing Checkov v${CHECKOV_VERSION}..."
pip3 install "checkov==${CHECKOV_VERSION}"

# Create .tflint.hcl config file
mkdir -p /home/vscode/.tflint.d
cat > /home/vscode/.tflint.hcl << EOF
plugin "aws" {
  enabled = true
}

plugin "azurerm" {
  enabled = true
}

plugin "google" {
  enabled = true
}
EOF

# Set ownership for the config file
chown -R vscode:vscode /home/vscode/.tflint.d

echo "Terraform tools installation complete!"
