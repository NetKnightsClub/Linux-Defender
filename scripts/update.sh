#!/bin/bash

# update.sh
# This script checks for updates from the GitHub repository and applies them.
# Unfished... btw.

REPO="https://github.com/VisAwesme/Linux-Defender.git"
LOCAL_DIR="$HOME/Linux-Defender"

echo "Checking for updates for Linux-Defender..."

# Pull the latest changes from the repository
if [ ! -d "$LOCAL_DIR" ]; then
    git clone "$REPO" "$LOCAL_DIR"
    echo "Cloned repository to $LOCAL_DIR."
else
    cd "$LOCAL_DIR"
    git pull
    echo "Pulled latest changes in $LOCAL_DIR."
fi

# Reinstall dependencies if needed
echo "Reinstalling dependencies..."
pip3 install -r requirements.txt

# Update complete
echo "Update complete. Linux-Defender is up to date."
