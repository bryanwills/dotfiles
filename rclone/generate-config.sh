#!/bin/bash

# Rclone Config Generation Script
# This script generates a secure rclone.conf from the template and environment variables

echo "Generating secure rclone configuration..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "Error: .env file not found!"
    echo "Please run setup-env.sh first to create the .env file."
    exit 1
fi

# Check if template exists
if [ ! -f rclone.conf.template ]; then
    echo "Error: rclone.conf.template not found!"
    exit 1
fi

# Source the environment variables
echo "Loading environment variables from .env file..."
source .env

# Check if required environment variables are set
required_vars=("RCLONE_CLIENT_ID" "RCLONE_CLIENT_SECRET" "RCLONE_ACCESS_TOKEN" "RCLONE_TOKEN_TYPE" "RCLONE_REFRESH_TOKEN" "RCLONE_TOKEN_EXPIRY" "RCLONE_TOKEN_EXPIRES_IN")

for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ] || [ "${!var}" = "your_actual_client_id_here" ] || [ "${!var}" = "your_actual_client_secret_here" ]; then
        echo "Warning: $var is not set or still has placeholder value"
        echo "Please update your .env file with actual values"
    fi
done

# Check if envsubst is available
if ! command -v envsubst &> /dev/null; then
    echo "Error: envsubst command not found!"
    echo "Please install gettext package:"
    echo "  macOS: brew install gettext"
    echo "  Ubuntu/Debian: sudo apt-get install gettext-base"
    echo "  CentOS/RHEL: sudo yum install gettext"
    exit 1
fi

# Generate the config
echo "Generating rclone.conf from template..."
envsubst < rclone.conf.template > rclone.conf

if [ $? -eq 0 ]; then
    echo "Successfully generated rclone.conf!"
    echo "Your configuration is now secure and uses environment variables."
    echo ""
    echo "To use rclone with this config:"
    echo "1. Make sure your .env file is loaded: source .env"
    echo "2. Run rclone commands normally"
    echo ""
    echo "Note: Keep your .env file secure and never commit it to version control!"
else
    echo "Error: Failed to generate rclone.conf"
    exit 1
fi
