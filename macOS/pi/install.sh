#!/bin/bash
set -o pipefail

# Pi coding agent — https://pi.dev
# Idempotent: skips when pi is already on PATH. Run `pi update` to upgrade.
# First-run config (login, model selection) is interactive: /login and /model.

if command -v pi &>/dev/null; then
  echo "pi already installed ($(pi --version 2>/dev/null || echo 'version unknown'))"
  exit 0
fi

if ! command -v npm &>/dev/null; then
  echo "Error: npm not found. Install Node.js first (step 2 installs it via brew)." >&2
  exit 1
fi

echo "Installing Pi via the official installer..."
curl -fsSL https://pi.dev/install.sh | sh

if command -v pi &>/dev/null; then
  echo "Pi installed: $(pi --version)"
else
  echo "Pi installed, but not on PATH yet. Restart your shell or add ~/.local/bin to PATH."
fi
