#!/bin/bash
set -e

echo "Installing Claude Code..."
brew install claude-code 2>/dev/null || echo "claude-code already installed"

echo "Installing plugins..."
claude plugins install superpowers@claude-plugins-official 2>/dev/null || echo "superpowers already installed"
claude plugins install context7@claude-plugins-official 2>/dev/null || echo "context7 already installed"
claude plugins install skill-creator@claude-plugins-official 2>/dev/null || echo "skill-creator already installed"

echo "Done. Next: copy macOS/claude_code/settings.json to ~/.claude/settings.json"
echo "       copy macOS/claude_code/mcp.json to ~/.claude/mcp.json"
