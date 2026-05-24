# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal macOS development environment setup repository. It contains installation scripts and configuration files to bootstrap a new macOS machine for development work.

## Repo structure

- `README.md` — canonical step-by-step setup guide; covers all manual installs, configuration, and useful applications
- `setup.sh` — master entrypoint script that runs all automated install steps in order: Homebrew, CLI tools, Claude Code, VS Code
- `macOS/install_homebrew.sh` — one-liner script to install Homebrew
- `macOS/install_required_app_by_brew.sh` — installs CLI tools, fonts, and apps via Homebrew
- `macOS/claude_code/` — Claude Code setup: install script, settings.json (pre-approved permissions, 4 plugins, HUD statusline), hud-config.json, and `profiles/` (custom model profile templates)
- `macOS/vscode/` — VS Code: `extensions.txt` (16 extensions, one per line), `install_extensions.sh` (installs VS Code if missing, installs extensions idempotently, merges settings additively), `settings.json`
- `macOS/ghostty/config` — GPU-accelerated terminal config (manual copy, not in setup.sh)
- `macOS/starship/starship.toml` — Shell prompt config with Catppuccin Mocha palette (manual copy, not in setup.sh)
- `macOS/iterm2/profile.json` — iTerm2 profile export, kept as a legacy fallback

## Architecture notes

- **setup.sh runs 1–4 in order.** Each step calls a child script. If a step fails mid-way, re-running setup.sh is safe — all child scripts are idempotent (check before install, skip if present).
- **VS Code settings merge is additive.** `install_extensions.sh` uses a Python script to read the repo's `settings.json`, strip JS-style `//` comments, and only add keys that don't already exist in the user's `settings.json`. Existing settings are never overwritten. This means local tweaks survive re-provisioning.
- **Ghostty and Starship are manual copy steps.** They are installed by brew but configs are not symlinked or copied by `setup.sh`. Users must copy them into place themselves (paths are in README).
- **Claude Code configs are copied directly.** `macOS/claude_code/install.sh` copies `settings.json` and `hud-config.json` into `~/.claude/`. The HUD statusline requires `bun` to be installed (referenced via `~/.bun/bin/bun` in the statusLine command). The `profiles/` directory contains templates only — users copy them into `~/.claude/profiles/` manually.
- **All scripts are standalone.** Each script can be run independently (e.g., re-run just the VS Code step without re-running the full `setup.sh`).

## When adding to this repo

- Place macOS-specific files under `macOS/`. If scripts for other platforms are added, create parallel top-level directories (e.g., `linux/`).
- Shell scripts should be plain `sh` or `bash`, executable, and idempotent where possible (re-running them should be safe).
- Configuration files (IDE profiles, terminal profiles, dotfile snippets) should be the raw export format the tool consumes, with personal paths/names replaced by placeholder comments where appropriate.
- Update `README.md` if a new tool or configuration step is added.
