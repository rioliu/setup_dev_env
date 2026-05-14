#!/bin/bash
set -e

if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew not found. Install it first:"
  echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  exit 1
fi

echo "Installing Claude Code..."
brew list --formula claude-code &>/dev/null && echo "claude-code already installed" || brew install claude-code

echo "Installing plugins..."
claude plugins list 2>/dev/null | grep -q "superpowers@claude-plugins-official" && echo "superpowers already installed" || claude plugins install superpowers@claude-plugins-official
claude plugins list 2>/dev/null | grep -q "context7@claude-plugins-official" && echo "context7 already installed" || claude plugins install context7@claude-plugins-official
claude plugins list 2>/dev/null | grep -q "skill-creator@claude-plugins-official" && echo "skill-creator already installed" || claude plugins install skill-creator@claude-plugins-official
claude plugins list 2>/dev/null | grep -q "github@claude-plugins-official" && echo "github already installed" || claude plugins install github@claude-plugins-official
echo "Adding community marketplace..."
claude plugins marketplace add jarrodwatts/claude-hud 2>/dev/null || true
claude plugins list 2>/dev/null | grep -q "claude-hud" && echo "claude-hud already installed" || claude plugins install claude-hud

echo "Done. Next: copy macOS/claude_code/settings.json to ~/.claude/settings.json"
