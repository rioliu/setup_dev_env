#!/usr/bin/env bash
# Install VS Code extensions and merge settings.json
# Usage: ./install_extensions.sh

set -euo pipefail

if ! command -v code &> /dev/null; then
    echo "Warning: 'code' CLI not found. Install VS Code first, then re-run this script." >&2
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

# ── Extensions ──────────────────────────────────
echo ">>> Installing VS Code extensions..."

INSTALLED=$(code --list-extensions)

while IFS= read -r ext; do
    [[ -z "$ext" || "$ext" =~ ^# ]] && continue
    if echo "$INSTALLED" | grep -Fxq "$ext"; then
        echo "  $ext (already installed, skipping)"
    else
        echo "  $ext"
        code --install-extension "$ext"
    fi
done < "$SCRIPT_DIR/extensions.txt"

# ── Settings ─────────────────────────────────────
echo ">>> Merging settings into existing settings.json..."

REPO_SETTINGS="$SCRIPT_DIR/settings.json"
USER_SETTINGS="$VSCODE_USER_DIR/settings.json"

python3 - "$REPO_SETTINGS" "$USER_SETTINGS" <<'PYEOF'
import sys, json, os

def strip_comments(text):
    lines = []
    for line in text.split('\n'):
        in_string = False
        result = []
        i = 0
        while i < len(line):
            if line[i] == '"' and (i == 0 or line[i-1] != '\\'):
                in_string = not in_string
                result.append(line[i])
            elif line[i:i+2] == '//' and not in_string:
                break
            else:
                result.append(line[i])
            i += 1
        lines.append(''.join(result))
    return '\n'.join(lines)

repo = json.loads(strip_comments(open(sys.argv[1]).read()))
user = json.loads(strip_comments(open(sys.argv[2]).read()))

added = 0
for key, value in repo.items():
    if key not in user:
        user[key] = value
        added += 1

with open(sys.argv[2], 'w') as f:
    json.dump(user, f, indent=4)
    f.write('\n')

print(f"  Added {added} new keys, skipped {len(repo) - added} existing")
PYEOF

echo "Done."
