#!/usr/bin/env bash
set -euo pipefail

# This script installs AWS CLI, Azure CLI, and Google Cloud SDK
#
# Hardening notes (2026-06):
#   - AWS CLI: download zip + GPG-verify against published .sig using
#     the AWS CLI Team public key (key id A6310ACC4672475C, fingerprint
#     FB5DB77FD5C118B80511ADA8A6310ACC4672475C). Source:
#     https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
#   - Azure CLI: install via signed Microsoft apt repo instead of piping
#     `curl https://aka.ms/InstallAzureCLIDeb | sudo bash`. Documented at
#     https://learn.microsoft.com/cli/azure/install-azure-cli-linux?pivots=apt
#   - Google Cloud SDK: dearmor the apt key into /usr/share/keyrings and
#     reference it via `signed-by=`, replacing the deprecated `apt-key add`.
#
# Architecture support (2026-06):
#   Detect the build host arch via `dpkg --print-architecture` and pick
#   per-tool naming. This lets the same Dockerfile build natively on amd64
#   and arm64 (e.g. Apple Silicon) without producing a mixed-arch image.
DPKG_ARCH="$(dpkg --print-architecture)"
case "${DPKG_ARCH}" in
    amd64) ;;
    arm64) ;;
    *) echo "Unsupported architecture: ${DPKG_ARCH}" >&2; exit 1 ;;
esac

# AWS CLI v2 installer uses x86_64 / aarch64 (Linux kernel naming).
case "${DPKG_ARCH}" in
    amd64) AWSCLI_ARCH="x86_64" ;;
    arm64) AWSCLI_ARCH="aarch64" ;;
esac

# Always clean up tmp artifacts on exit (success or failure)
cleanup() {
    rm -rf /tmp/aws /tmp/awscliv2.zip /tmp/awscliv2.sig /tmp/aws-cli-pgp.key /tmp/aws-cli-gnupghome
}
trap cleanup EXIT

# Install AWS CLI v2
echo "Installing AWS CLI v2 (${AWSCLI_ARCH})..."
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip" -o /tmp/awscliv2.zip
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip.sig" -o /tmp/awscliv2.sig

# Pinned AWS CLI Team OpenPGP public key (RSA 4096, key id A6310ACC4672475C).
# This block is reproduced verbatim from the AWS CLI install docs so that the
# build does not have to trust an arbitrary keyserver lookup at run time.
cat > /tmp/aws-cli-pgp.key <<'AWS_CLI_PGP_KEY'
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBF2Cr7UBEADJZHcgusOJl7ENSyumXh85z0TRV0xJorM2B/JL0kHOyigQluUG
ZMLhENaG0bYatdrKP+3H91lvK050pXwnO/R7fB/FSTouki4ciIx5OuLlnJZIxSzx
PqGl0mkxImLNbGWoi6Lto0LYxqHN2iQtzlwTVmq9733zd3XfcXrZ3+LblHAgEt5G
TfNxEKJ8soPLyWmwDH6HWCnjZ/aIQRBTIQ05uVeEoYxSh6wOai7ss/KveoSNBbYz
gbdzoqI2Y8cgH2nbfgp3DSasaLZEdCSsIsK1u05CinE7k2qZ7KgKAUIcT/cR/grk
C6VwsnDU0OUCideXcQ8WeHutqvgZH1JgKDbznoIzeQHJD238GEu+eKhRHcz8/jeG
94zkcgJOz3KbZGYMiTh277Fvj9zzvZsbMBCedV1BTg3TqgvdX4bdkhf5cH+7NtWO
lrFj6UwAsGukBTAOxC0l/dnSmZhJ7Z1KmEWilro/gOrjtOxqRQutlIqG22TaqoPG
fYVN+en3Zwbt97kcgZDwqbuykNt64oZWc4XKCa3mprEGC3IbJTBFqglXmZ7l9ywG
EEUJYOlb2XrSuPWml39beWdKM8kzr1OjnlOm6+lpTRCBfo0wa9F8YZRhHPAkwKkX
XDeOGpWRj4ohOx0d2GWkyV5xyN14p2tQOCdOODmz80yUTgRpPVQUtOEhXQARAQAB
tCFBV1MgQ0xJIFRlYW0gPGF3cy1jbGlAYW1hem9uLmNvbT6JAlQEEwEIAD4CGwMF
CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQT7Xbd/1cEYuAURraimMQrMRnJHXAUC
aGveYQUJDMpiLAAKCRCmMQrMRnJHXKBYD/9Ab0qQdGiO5hObchG8xh8Rpb4Mjyf6
0JrVo6m8GNjNj6BHkSc8fuTQJ/FaEhaQxj3pjZ3GXPrXjIIVChmICLlFuRXYzrXc
Pw0lniybypsZEVai5kO0tCNBCCFuMN9RsmmRG8mf7lC4FSTbUDmxG/QlYK+0IV/l
uJkzxWa+rySkdpm0JdqumjegNRgObdXHAQDWlubWQHWyZyIQ2B4U7AxqSpcdJp6I
S4Zds4wVLd1WE5pquYQ8vS2cNlDm4QNg8wTj58e3lKN47hXHMIb6CHxRnb947oJa
pg189LLPR5koh+EorNkA1wu5mAJtJvy5YMsppy2y/kIjp3lyY6AmPT1posgGk70Z
CmToEZ5rbd7ARExtlh76A0cabMDFlEHDIK8RNUOSRr7L64+KxOUegKBfQHb9dADY
qqiKqpCbKgvtWlds909Ms74JBgr2KwZCSY1HaOxnIr4CY43QRqAq5YHOay/mU+6w
hhmdF18vpyK0vfkvvGresWtSXbag7Hkt3XjaEw76BzxQH21EBDqU8WJVjHgU6ru+
DJTs+SxgJbaT3hb/vyjlw0lK+hFfhWKRwgOXH8vqducF95NRSUxtS4fpqxWVaw3Q
V2OWSjbne99A5EPEySzryFTKbMGwaTlAwMCwYevt4YT6eb7NmFhTx0Fis4TalUs+
j+c7Kg92pDx2uQ==
=OBAt
-----END PGP PUBLIC KEY BLOCK-----
AWS_CLI_PGP_KEY

# Verify the signature in an isolated GNUPGHOME so we don't pollute the user's keyring
mkdir -m 700 -p /tmp/aws-cli-gnupghome
GNUPGHOME=/tmp/aws-cli-gnupghome gpg --batch --import /tmp/aws-cli-pgp.key
GNUPGHOME=/tmp/aws-cli-gnupghome gpg --batch --verify /tmp/awscliv2.sig /tmp/awscliv2.zip

unzip -qq /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install

# Install Azure CLI from the official Microsoft apt repo.
# Replaces the previous `curl https://aka.ms/InstallAzureCLIDeb | sudo bash`
# which executed a remote script as root.
echo "Installing Azure CLI..."
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | sudo gpg --dearmor -o /usr/share/keyrings/microsoft.gpg
AZ_REPO="$(lsb_release -cs)"
echo "deb [arch=${DPKG_ARCH} signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ ${AZ_REPO} main" \
    | sudo tee /etc/apt/sources.list.d/azure-cli.list > /dev/null
sudo apt-get update
sudo apt-get install -y azure-cli

# Install Google Cloud SDK using a keyring file referenced by `signed-by=`.
# The deprecated `apt-key add` is no longer used.
echo "Installing Google Cloud SDK..."
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list > /dev/null
sudo apt-get update
sudo apt-get install -y google-cloud-cli

# Create directories for credentials
mkdir -p /home/vscode/.aws
mkdir -p /home/vscode/.azure
mkdir -p /home/vscode/.config/gcloud

# Set proper ownership
chown -R vscode:vscode /home/vscode/.aws
chown -R vscode:vscode /home/vscode/.azure
chown -R vscode:vscode /home/vscode/.config/gcloud

echo "Cloud CLI tools installation complete!"
