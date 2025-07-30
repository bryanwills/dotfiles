#!/bin/bash

# My Current macOS Defaults
# Generated on Wed Jul 30 16:52:01 EDT 2025

# Screenshot Settings
defaults write com.apple.screencapture location "/Users/bryanwills/screenshots"
defaults write com.apple.screencapture type "png"
defaults write com.apple.screencapture thumbnail-duration -float 1.0

# Dock Settings
defaults write com.apple.dock autohide -bool 1
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock tilesize -int 49
defaults write com.apple.dock magnification -bool 1

# Global Settings
defaults write NSGlobalDomain AppleShowAllExtensions -bool 1
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool 0

echo "Settings applied! Some changes may require a restart."
echo "To restart Dock: killall Dock"
echo "To restart Finder: killall Finder"
