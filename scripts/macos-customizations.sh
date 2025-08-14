#!/bin/bash

# macOS Customizations Script
# Run this script to apply custom macOS settings

echo "Applying macOS customizations..."

# Screenshot settings
echo "Configuring screenshot behavior..."
defaults write com.apple.screencapture show-thumbnail -bool false
# Or to keep thumbnail but make it disappear faster:
# defaults write com.apple.screencapture thumbnail-duration -float 1.0

# Dock settings
echo "Configuring Dock..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Finder settings
echo "Configuring Finder..."
defaults write com.finder ShowPathbar -bool true
defaults write com.finder ShowStatusBar -bool true
defaults write com.finder FXPreferredViewStyle -string "Nlsv"  # List view

# System settings
echo "Configuring system preferences..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Mission Control
echo "Configuring Mission Control..."
defaults write com.apple.dock mru-spaces -bool false

# Security
echo "Configuring security settings..."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# .DS_Store Prevention
echo "Configuring .DS_Store prevention..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.desktopservices DSDontWriteUSBStores true
defaults write com.apple.desktopservices DSDontWriteLocalStores true

echo "Customizations applied! Some changes may require a restart to take effect."
echo "To restart: sudo shutdown -r now"
