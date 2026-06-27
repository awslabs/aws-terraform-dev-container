#!/usr/bin/env bash
set -e

# AWS Authentication Helper Script

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it first."
    exit 1
fi

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --profile PROFILE    AWS profile to use"
    echo "  --region REGION      AWS region to use"
    echo "  --sso                Use AWS SSO for authentication"
    echo "  --help               Display this help message"
    exit 1
}

# Parse arguments
PROFILE=""
REGION=""
USE_SSO=false

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --profile)
            PROFILE="$2"
            shift
            shift
            ;;
        --region)
            REGION="$2"
            shift
            shift
            ;;
        --sso)
            USE_SSO=true
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

# Set profile if provided
if [ -n "$PROFILE" ]; then
    export AWS_PROFILE="$PROFILE"
    echo "Using AWS profile: $AWS_PROFILE"
fi

# Set region if provided
if [ -n "$REGION" ]; then
    export AWS_REGION="$REGION"
    echo "Using AWS region: $AWS_REGION"
fi

# Use SSO if requested
if [ "$USE_SSO" = true ]; then
    echo "Authenticating with AWS SSO..."
    aws sso login

    # Verify authentication
    echo "Verifying authentication..."
    aws sts get-caller-identity
else
    # Verify credentials
    echo "Verifying AWS credentials..."
    aws sts get-caller-identity
fi

echo "AWS authentication complete!"
