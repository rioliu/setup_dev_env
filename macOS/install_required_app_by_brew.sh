#!/bin/bash
set -e

# Core CLI
for pkg in bash-completion coreutils wget curl tree jq git kubernetes-cli nmap python uv node; do
  brew list --formula "$pkg" &>/dev/null && echo "$pkg already installed" || brew install "$pkg"
done

# Modern CLI tools
for pkg in fzf ripgrep fd bat git-delta zoxide bottom tlrc lsd starship lazygit gh; do
  brew list --formula "$pkg" &>/dev/null && echo "$pkg already installed" || brew install "$pkg"
done

# Go tools
brew list --formula golangci-lint &>/dev/null && echo "golangci-lint already installed" || brew install golangci-lint

# Apps
brew list --cask ghostty &>/dev/null && echo "ghostty already installed" || brew install --cask ghostty

# Fonts
for font in font-jetbrains-mono-nerd-font font-droid-sans-mono-nerd-font font-hack-nerd-font font-maple-mono-nf-cn; do
  brew list --cask "$font" &>/dev/null && echo "$font already installed" || brew install "$font"
done
