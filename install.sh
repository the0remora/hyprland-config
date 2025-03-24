#!/bin/bash
clear  # Ensures a clean terminal output

# Define repository and install path
REPO_URL="https://github.com/the0remora/hyprland-config.git"
CONFIG_DIR="$HOME/.config"

# Install dependencies
echo "Installing dependencies..."
yay -S --noconfirm hyprland waybar wofi hyprpaper hyprshade

# Clone the dotfiles repo
echo "Cloning Hyprland configuration..."
if [ ! -d "$CONFIG_DIR/hypr" ]; then
    git clone "$REPO_URL" "$CONFIG_DIR/hyprland-setup"
else
    echo "Config already exists. Pulling latest updates..."
    cd "$CONFIG_DIR/hyprland-setup" && git pull
fi

# Move configuration files
echo "Deploying configuration..."
mv -n "$CONFIG_DIR/hyprland-setup/hypr" "$CONFIG_DIR/"
mv -n "$CONFIG_DIR/hyprland-setup/waybar" "$CONFIG_DIR/"
mv -n "$CONFIG_DIR/hyprland-setup/wofi" "$CONFIG_DIR/"
mv -n "$CONFIG_DIR/hyprland-setup/wallpapers" "$CONFIG_DIR/"

# Enable Hyprshade
echo "Enabling Hyprshade..."
hyprctl setcursor --shades true

# Clean up
rm -rf "$CONFIG_DIR/hyprland-setup"

echo "Setup complete! Restart Hyprland to apply changes."
