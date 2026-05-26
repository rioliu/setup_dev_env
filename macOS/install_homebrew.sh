#!/bin/bash
set -e

if command -v brew &>/dev/null; then
  echo "Homebrew already installed ($(brew --version | head -1))"
  exit 0
fi

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
