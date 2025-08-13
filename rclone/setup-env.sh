#!/bin/bash

# Rclone Environment Setup Script
# This script helps you set up environment variables for rclone configuration

echo "Setting up Rclone environment variables..."

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << 'EOF'
# Rclone Google Drive Configuration
# Replace these placeholder values with your actual credentials

# Google OAuth Client ID
=your_actual_client_id_here

# Google OAuth Client Secret
RCLONE_CLIENT_SECRET=your_actual_client_secret_here

# Google OAuth Token (this will be automatically refreshed by rclone)
# The token below is the current one from your config - you'll need to update this
# when it expires or if you want to regenerate it


# Token type (usually Bearer)


# Refresh token for automatic renewal


# Token expiry (ISO 8601 format)


# Token expires in (seconds)

EOF
    echo ".env file created successfully!"
else
    echo ".env file already exists. Please update it with your actual credentials."
fi

echo ""
echo "Next steps:"
echo "1. Edit the .env file and replace the placeholder values with your actual credentials"
echo "2. Run: source .env && envsubst < rclone.conf.template > rclone.conf"
echo "3. Or use the generate-config.sh script to automatically generate the config"
echo ""
echo "Note: Make sure to add .env to your .gitignore file to keep secrets secure!"
