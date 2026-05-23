#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="macOS"

echo "============================================"
echo "  Dev Environment Setup"
echo "============================================"
echo ""

# Step 1: Homebrew
echo ">>> Step 1/4: Installing Homebrew..."
bash "$SCRIPT_DIR/$OS/install_homebrew.sh"
echo ""

# Step 2: Brew packages and fonts
echo ">>> Step 2/4: Installing CLI tools, apps, and fonts..."
bash "$SCRIPT_DIR/$OS/install_required_app_by_brew.sh"
echo ""

# Step 3: Claude Code + plugins + configs
echo ">>> Step 3/4: Installing Claude Code and plugins..."
bash "$SCRIPT_DIR/$OS/claude_code/install.sh"
echo ""

# Step 4: VS Code extensions and settings
echo ">>> Step 4/4: Configuring VS Code..."
bash "$SCRIPT_DIR/$OS/vscode/install_extensions.sh"
echo ""

echo "============================================"
echo "  Automated setup complete!"
echo ""
echo "  Manual steps remaining:"
echo "    - Install VS Code (if not already)"
echo "    - Install Podman Desktop (see README)"
echo "    - Configure shell profile (see README)"
echo "    - Configure vim (see README)"
echo "============================================"
