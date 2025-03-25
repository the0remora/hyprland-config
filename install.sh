#!/bin/bash

# Hyprland Installation Script

# Function to check if a package is installed
is_installed() {
    pacman -Q $1 &>/dev/null
}

echo "Updating system..."
yay -Syu --noconfirm || { echo "Failed to update system"; exit 1; }

# Install required packages
PACKAGES=(
    "hyprland"
    "waybar"
    "rofi"
    "foot"
    "thunar"
    "swaync"
    "hyprpaper"
    "hyprshade"
)

echo "Installing necessary packages..."
for PKG in "${PACKAGES[@]}"; do
    if is_installed $PKG; then
        echo "$PKG is already installed."
    else
        yay -S --noconfirm $PKG || { echo "Failed to install $PKG"; exit 1; }
    fi
done

# Backup existing Hyprland config
CONFIG_DIR="$HOME/.config/hypr"
mkdir -p "$CONFIG_DIR"

for FILE in hyprland.conf monitors.conf env.conf; do
    if [ -f "$CONFIG_DIR/$FILE" ]; then
        mv "$CONFIG_DIR/$FILE" "$CONFIG_DIR/$FILE.bak"
        echo "Backed up existing $FILE"
    fi
done

# Copy new configuration
echo "Deploying new Hyprland configuration..."
cp hyprland.conf monitors.conf env.conf "$CONFIG_DIR/"

echo "Installation complete! Restart Hyprland to apply changes."
