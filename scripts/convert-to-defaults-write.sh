#!/bin/bash

# Convert Current Settings to Defaults Write Commands
# This script converts your current settings into defaults write commands

echo "Converting current settings to defaults write commands..."

OUTPUT_FILE="my-current-defaults.sh"
echo "#!/bin/bash" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "# My Current macOS Defaults" >> "$OUTPUT_FILE"
echo "# Generated on $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Screenshot settings
echo "# Screenshot Settings" >> "$OUTPUT_FILE"
if defaults read com.apple.screencapture location > /dev/null 2>&1; then
    LOCATION=$(defaults read com.apple.screencapture location)
    echo "defaults write com.apple.screencapture location \"$LOCATION\"" >> "$OUTPUT_FILE"
fi

if defaults read com.apple.screencapture type > /dev/null 2>&1; then
    TYPE=$(defaults read com.apple.screencapture type)
    echo "defaults write com.apple.screencapture type \"$TYPE\"" >> "$OUTPUT_FILE"
fi

# Note: show-thumbnail is not set, so it's using default (true)
echo "# Screenshot thumbnail is currently enabled (default)" >> "$OUTPUT_FILE"
echo "# To disable: defaults write com.apple.screencapture show-thumbnail -bool false" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Dock settings
echo "# Dock Settings" >> "$OUTPUT_FILE"
if defaults read com.apple.dock autohide > /dev/null 2>&1; then
    AUTOHIDE=$(defaults read com.apple.dock autohide)
    echo "defaults write com.apple.dock autohide -bool $AUTOHIDE" >> "$OUTPUT_FILE"
fi

if defaults read com.apple.dock autohide-delay > /dev/null 2>&1; then
    DELAY=$(defaults read com.apple.dock autohide-delay)
    echo "defaults write com.apple.dock autohide-delay -float $DELAY" >> "$OUTPUT_FILE"
fi

if defaults read com.apple.dock autohide-time-modifier > /dev/null 2>&1; then
    MODIFIER=$(defaults read com.apple.dock autohide-time-modifier)
    echo "defaults write com.apple.dock autohide-time-modifier -float $MODIFIER" >> "$OUTPUT_FILE"
fi

if defaults read com.apple.dock tilesize > /dev/null 2>&1; then
    TILESIZE=$(defaults read com.apple.dock tilesize)
    echo "defaults write com.apple.dock tilesize -int $TILESIZE" >> "$OUTPUT_FILE"
fi

if defaults read com.apple.dock magnification > /dev/null 2>&1; then
    MAGNIFICATION=$(defaults read com.apple.dock magnification)
    echo "defaults write com.apple.dock magnification -bool $MAGNIFICATION" >> "$OUTPUT_FILE"
fi
echo "" >> "$OUTPUT_FILE"

# Global settings
echo "# Global Settings" >> "$OUTPUT_FILE"
if defaults read NSGlobalDomain AppleShowAllExtensions > /dev/null 2>&1; then
    SHOW_EXTENSIONS=$(defaults read NSGlobalDomain AppleShowAllExtensions)
    echo "defaults write NSGlobalDomain AppleShowAllExtensions -bool $SHOW_EXTENSIONS" >> "$OUTPUT_FILE"
fi

if defaults read NSGlobalDomain NSDocumentSaveNewDocumentsToCloud > /dev/null 2>&1; then
    SAVE_TO_CLOUD=$(defaults read NSGlobalDomain NSDocumentSaveNewDocumentsToCloud)
    echo "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool $SAVE_TO_CLOUD" >> "$OUTPUT_FILE"
fi
echo "" >> "$OUTPUT_FILE"

echo "echo \"Settings applied! Some changes may require a restart.\"" >> "$OUTPUT_FILE"
echo "echo \"To restart Dock: killall Dock\"" >> "$OUTPUT_FILE"
echo "echo \"To restart Finder: killall Finder\"" >> "$OUTPUT_FILE"

chmod +x "$OUTPUT_FILE"
echo "Conversion completed! Check $OUTPUT_FILE for your defaults write commands."