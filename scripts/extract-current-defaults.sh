#!/bin/bash

# Extract Current macOS Defaults Script
# This script extracts your current customized defaults settings

echo "Extracting current macOS defaults customizations..."

# Create output file
OUTPUT_FILE="current-defaults-export.sh"
echo "#!/bin/bash" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "# Current macOS Defaults Export" >> "$OUTPUT_FILE"
echo "# Generated on $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Screenshot settings
echo "Extracting screenshot settings..."
if defaults read com.apple.screencapture > /dev/null 2>&1; then
    echo "# Screenshot Settings" >> "$OUTPUT_FILE"
    defaults read com.apple.screencapture | grep -E "(show-thumbnail|thumbnail-duration|location|type)" >> "$OUTPUT_FILE" 2>/dev/null || echo "# No custom screenshot settings found" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Dock settings
echo "Extracting dock settings..."
if defaults read com.apple.dock > /dev/null 2>&1; then
    echo "# Dock Settings" >> "$OUTPUT_FILE"
    defaults read com.apple.dock | grep -E "(autohide|autohide-delay|autohide-time-modifier|tilesize|magnification)" >> "$OUTPUT_FILE" 2>/dev/null || echo "# No custom dock settings found" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Finder settings
echo "Extracting finder settings..."
if defaults read com.finder > /dev/null 2>&1; then
    echo "# Finder Settings" >> "$OUTPUT_FILE"
    defaults read com.finder | grep -E "(ShowPathbar|ShowStatusBar|FXPreferredViewStyle)" >> "$OUTPUT_FILE" 2>/dev/null || echo "# No custom finder settings found" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Global settings
echo "Extracting global settings..."
if defaults read NSGlobalDomain > /dev/null 2>&1; then
    echo "# Global Settings" >> "$OUTPUT_FILE"
    defaults read NSGlobalDomain | grep -E "(AppleShowAllExtensions|NSDocumentSaveNewDocumentsToCloud)" >> "$OUTPUT_FILE" 2>/dev/null || echo "# No custom global settings found" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Security settings
echo "Extracting security settings..."
if defaults read com.apple.screensaver > /dev/null 2>&1; then
    echo "# Security Settings" >> "$OUTPUT_FILE"
    defaults read com.apple.screensaver | grep -E "(askForPassword|askForPasswordDelay)" >> "$OUTPUT_FILE" 2>/dev/null || echo "# No custom security settings found" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

echo "Export completed! Check $OUTPUT_FILE for your current customizations."
echo ""
echo "To apply these settings on another machine, run:"
echo "chmod +x $OUTPUT_FILE && ./$OUTPUT_FILE"