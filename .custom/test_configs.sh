#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Source directory
SOURCE_DIR="$HOME/.config.bak"

# Target directory
TARGET_DIR="$HOME/.test"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

echo "Creating symlinks from $SOURCE_DIR to $TARGET_DIR"

# Process all entries in .config (top-level only)
for item in "$SOURCE_DIR"/*; do
    # Get the base name
    base_name=$(basename "$item")
    
    # Target path
    target="$TARGET_DIR/$base_name"
    
    # Skip if already exists in target
    if [ -e "$target" ]; then
        echo -e "${YELLOW}Skipping $base_name (already exists in $TARGET_DIR)${NC}"
        continue
    fi
    
    # Create the symlink
    ln -s "$item" "$target"
    echo -e "${GREEN}Created symlink: $target -> $item${NC}"
done

echo -e "\n${GREEN}All symlinks have been created successfully!${NC}" 