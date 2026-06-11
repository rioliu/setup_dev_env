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
claude plugins list 2>/dev/null | grep -q "context7@claude-plugins-official" && echo "context7 already installed" || claude plugins install context7@claude-plugins-official
claude plugins list 2>/dev/null | grep -q "skill-creator@claude-plugins-official" && echo "skill-creator already installed" || claude plugins install skill-creator@claude-plugins-official
echo "Adding community marketplace..."
claude plugins marketplace add jarrodwatts/claude-hud 2>/dev/null || true
claude plugins list 2>/dev/null | grep -q "claude-hud" && echo "claude-hud already installed" || claude plugins install claude-hud

echo "Merging configs..."
REPO_SETTINGS="$(dirname "$0")/settings.json"
USER_SETTINGS="$HOME/.claude/settings.json"

if [ -f "$USER_SETTINGS" ]; then
  python3 - "$REPO_SETTINGS" "$USER_SETTINGS" <<'PYEOF'
import sys, json

repo = json.load(open(sys.argv[1]))
user = json.load(open(sys.argv[2]))

def deep_merge(base, override):
    """Merge override into base. For dicts, recurse. Otherwise override wins only if key is new."""
    added = 0
    for key, value in override.items():
        if key not in base:
            base[key] = value
            added += 1
        elif isinstance(base[key], dict) and isinstance(value, dict):
            added += deep_merge(base[key], value)
    return added

added = deep_merge(user, repo)
with open(sys.argv[2], 'w') as f:
    json.dump(user, f, indent=2)
    f.write('\n')
print(f"  Added {added} new keys, skipped existing")
PYEOF
else
  mkdir -p ~/.claude
  cp "$REPO_SETTINGS" "$USER_SETTINGS"
  echo "  Created new settings.json"
fi

mkdir -p ~/.claude/plugins/claude-hud
cp "$(dirname "$0")/hud-config.json" ~/.claude/plugins/claude-hud/config.json
echo "Done. Restart claude to apply changes."
