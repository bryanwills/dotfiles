#!/bin/bash
# Clean .DS_Store files and prevent their creation
# Run this script to remove existing .DS_Store files and set up prevention

echo "Cleaning up .DS_Store files..."

# Remove existing .DS_Store files from current directory and subdirectories
find . -name ".DS_Store" -type f -delete

# Remove .DS_Store files from home directory
find ~ -name ".DS_Store" -type f -delete 2>/dev/null || true

# Remove .DS_Store files from common directories
find ~/Desktop -name ".DS_Store" -type f -delete 2>/dev/null || true
find ~/Documents -name ".DS_Store" -type f -delete 2>/dev/null || true
find ~/Downloads -name ".DS_Store" -type f -delete 2>/dev/null || true

echo "Setting up .DS_Store prevention..."

# Prevent .DS_Store creation on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Prevent .DS_Store creation on USB drives
defaults write com.apple.desktopservices DSDontWriteUSBStores true

# Prevent .DS_Store creation on local drives (aggressive)
defaults write com.apple.desktopservices DSDontWriteLocalStores true

echo "Restarting Finder to apply changes..."
killall Finder

echo "Done! .DS_Store files have been cleaned up and prevention is enabled."
echo "Note: Some applications may still create .DS_Store files. Run this script periodically to clean them up."
