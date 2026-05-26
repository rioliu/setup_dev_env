#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Ghostty
GHOSTTY_DIR=~/Library/Application\ Support/com.mitchellh.ghostty
if [ -f "$SCRIPT_DIR/ghostty/config" ]; then
  mkdir -p "$GHOSTTY_DIR"
  cp "$SCRIPT_DIR/ghostty/config" "$GHOSTTY_DIR/config"
  echo "Ghostty config deployed to $GHOSTTY_DIR/config"
fi

# Starship
if [ -f "$SCRIPT_DIR/starship/starship.toml" ]; then
  mkdir -p ~/.config
  cp "$SCRIPT_DIR/starship/starship.toml" ~/.config/starship.toml
  echo "Starship config deployed to ~/.config/starship.toml"
fi

# Claude Code profiles
if [ -d "$SCRIPT_DIR/claude_code/profiles" ]; then
  mkdir -p ~/.claude/profiles
  for profile in "$SCRIPT_DIR/claude_code/profiles"/*.json; do
    [ -f "$profile" ] || continue
    name=$(basename "$profile")
    if [ -f ~/.claude/profiles/"$name" ]; then
      echo "Claude profile $name already exists, skipping"
    else
      cp "$profile" ~/.claude/profiles/"$name"
      echo "Claude profile deployed to ~/.claude/profiles/$name"
    fi
  done
fi
