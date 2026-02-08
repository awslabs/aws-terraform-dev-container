#!/usr/bin/env bash
set -e

# GCP Authentication Helper Script

# Check if gcloud CLI is installed
if ! command -v gcloud &> /dev/null; then
    echo "Google Cloud SDK is not installed. Please install it first."
    exit 1
fi

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --project PROJECT_ID       GCP project ID to use"
    echo "  --credentials FILE_PATH    Path to service account key file"
    echo "  --help                     Display this help message"
    exit 1
}

# Parse arguments
PROJECT_ID=""
CREDENTIALS_FILE=""

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --project)
            PROJECT_ID="$2"
            shift
            shift
            ;;
        --credentials)
            CREDENTIALS_FILE="$2"
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

# Set project if provided
if [ -n "$PROJECT_ID" ]; then
    export CLOUDSDK_CORE_PROJECT="$PROJECT_ID"
    gcloud config set project "$PROJECT_ID"
    echo "Using GCP project: $PROJECT_ID"
fi

# Use service account key file if provided
if [ -n "$CREDENTIALS_FILE" ]; then
    if [ ! -f "$CREDENTIALS_FILE" ]; then
        echo "Error: Credentials file not found: $CREDENTIALS_FILE"
        exit 1
    fi

    export GOOGLE_APPLICATION_CREDENTIALS="$CREDENTIALS_FILE"
    echo "Using service account credentials: $CREDENTIALS_FILE"

    # Activate service account
    gcloud auth activate-service-account --key-file="$CREDENTIALS_FILE"
else
    echo "Authenticating with GCP interactive login..."
    gcloud auth login
fi

# Verify authentication
echo "Verifying GCP authentication..."
gcloud auth list

echo "GCP authentication complete!"
