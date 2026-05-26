#!/bin/bash
# Deploy Ghostty, Starship, and Claude Code profile configs.
# Each block is independent — a failure in one section does not abort the others.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
errors=0

# Ghostty
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
if [ -f "$SCRIPT_DIR/ghostty/config" ]; then
  if mkdir -p "$GHOSTTY_DIR" && cp "$SCRIPT_DIR/ghostty/config" "$GHOSTTY_DIR/config"; then
    echo "Ghostty config deployed to $GHOSTTY_DIR/config"
  else
    echo "ERROR: failed to deploy Ghostty config" >&2
    errors=$((errors + 1))
  fi
fi

# Starship
if [ -f "$SCRIPT_DIR/starship/starship.toml" ]; then
  if mkdir -p ~/.config && cp "$SCRIPT_DIR/starship/starship.toml" ~/.config/starship.toml; then
    echo "Starship config deployed to ~/.config/starship.toml"
  else
    echo "ERROR: failed to deploy Starship config" >&2
    errors=$((errors + 1))
  fi
fi

# Claude Code profiles
if [ -d "$SCRIPT_DIR/claude_code/profiles" ]; then
  if mkdir -p ~/.claude/profiles; then
    for profile in "$SCRIPT_DIR/claude_code/profiles"/*.json; do
      [ -f "$profile" ] || continue
      name=$(basename "$profile")
      if [ -f ~/.claude/profiles/"$name" ]; then
        echo "Claude profile $name already exists, skipping"
      elif cp "$profile" ~/.claude/profiles/"$name"; then
        echo "Claude profile deployed to ~/.claude/profiles/$name"
      else
        echo "ERROR: failed to deploy Claude profile $name" >&2
        errors=$((errors + 1))
      fi
    done
  else
    echo "ERROR: failed to create ~/.claude/profiles" >&2
    errors=$((errors + 1))
  fi
fi

if [ "$errors" -gt 0 ]; then
  echo ""
  echo "deploy_configs.sh finished with $errors error(s)" >&2
  exit 1
fi
