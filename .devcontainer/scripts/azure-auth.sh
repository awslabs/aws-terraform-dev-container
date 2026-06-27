#!/usr/bin/env bash
set -e

# Azure Authentication Helper Script

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "Azure CLI is not installed. Please install it first."
    exit 1
fi

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --subscription SUBSCRIPTION_ID    Azure subscription ID to use"
    echo "  --tenant TENANT_ID                Azure tenant ID to use"
    echo "  --service-principal               Use service principal authentication"
    echo "  --client-id CLIENT_ID             Service principal client ID"
    echo "  --client-secret CLIENT_SECRET     Service principal client secret"
    echo "  --help                            Display this help message"
    exit 1
}

# Parse arguments
SUBSCRIPTION_ID=""
TENANT_ID=""
USE_SP=false
CLIENT_ID=""
CLIENT_SECRET=""

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --subscription)
            SUBSCRIPTION_ID="$2"
            shift
            shift
            ;;
        --tenant)
            TENANT_ID="$2"
            shift
            shift
            ;;
        --service-principal)
            USE_SP=true
            shift
            ;;
        --client-id)
            CLIENT_ID="$2"
            shift
            shift
            ;;
        --client-secret)
            CLIENT_SECRET="$2"
            shift
            shift
            ;;
        --help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Set environment variables for Terraform
if [ -n "$SUBSCRIPTION_ID" ]; then
    export ARM_SUBSCRIPTION_ID="$SUBSCRIPTION_ID"
    echo "Using Azure subscription: $ARM_SUBSCRIPTION_ID"
fi

if [ -n "$TENANT_ID" ]; then
    export ARM_TENANT_ID="$TENANT_ID"
    echo "Using Azure tenant: $ARM_TENANT_ID"
fi

# Use service principal if requested
if [ "$USE_SP" = true ]; then
    if [ -z "$CLIENT_ID" ] || [ -z "$CLIENT_SECRET" ]; then
        echo "Error: Service principal authentication requires --client-id and --client-secret"
        exit 1
    fi

    export ARM_CLIENT_ID="$CLIENT_ID"
    export ARM_CLIENT_SECRET="$CLIENT_SECRET"

    echo "Authenticating with Azure service principal..."
    az login --service-principal --username "$CLIENT_ID" --password "$CLIENT_SECRET" --tenant "$TENANT_ID"
else
    echo "Authenticating with Azure interactive login..."
    az login

    # Set subscription if provided
    if [ -n "$SUBSCRIPTION_ID" ]; then
        az account set --subscription "$SUBSCRIPTION_ID"
    fi
fi

# Verify authentication
echo "Verifying Azure authentication..."
az account show

echo "Azure authentication complete!"
