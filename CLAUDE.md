# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal macOS development environment setup repository. It contains installation scripts and configuration files to bootstrap a new macOS machine for development work.

## Repo structure

- `README.md` — canonical step-by-step setup guide; covers all manual installs, configuration, and useful applications
- `setup.sh` — master entrypoint script that runs all automated install steps in order: Homebrew, CLI tools, Claude Code, VS Code, config deployment
- `macOS/install_homebrew.sh` — installs Homebrew (skips if present)
- `macOS/install_required_app_by_brew.sh` — installs CLI tools, fonts, and apps via Homebrew (idempotent)
- `macOS/deploy_configs.sh` — deploys Ghostty, Starship, and Claude profile configs (idempotent, never overwrites existing profiles)
- `macOS/claude_code/` — Claude Code setup: install script, settings.json (pre-approved permissions, 4 plugins, HUD statusline), hud-config.json, and `profiles/` (custom model profile templates)
- `macOS/vscode/` — VS Code: `extensions.txt` (16 extensions, one per line), `install_extensions.sh` (installs VS Code if missing, installs extensions idempotently, merges settings additively), `settings.json`
- `macOS/ghostty/config` — GPU-accelerated terminal config (deployed automatically by step 5)
- `macOS/starship/starship.toml` — Shell prompt config with Catppuccin Mocha palette (deployed automatically by step 5)
- `macOS/iterm2/profile.json` — iTerm2 profile export, kept as a legacy fallback

## Architecture notes

- **setup.sh runs 1–5 in order.** Each step calls a child script. If a step fails mid-way, re-running setup.sh is safe — all child scripts are idempotent (check before install, skip if present).
- **VS Code settings merge is additive.** `install_extensions.sh` uses a Python script to read the repo's `settings.json`, strip JS-style `//` comments, and only add keys that don't already exist in the user's `settings.json`. Existing settings are never overwritten. This means local tweaks survive re-provisioning.
- **Claude Code settings merge is also additive.** `claude_code/install.sh` does a deep merge — top-level keys and nested dicts (like `permissions.allow`) are only added if absent. Existing user customizations survive re-provisioning.
- **Ghostty and Starship configs are deployed automatically** by `macOS/deploy_configs.sh` (step 5 of setup.sh). Targets: `~/Library/Application Support/com.mitchellh.ghostty/config` and `~/.config/starship.toml`.
- **Claude Code HUD config is read from `~/.claude/plugins/claude-hud/config.json`.** The plugin source code (`getHudPluginDir()` in `cache/.../src/config.ts`) hard-codes this path. The statusLine command in settings.json globs the cache dir only to find the executable; config is always read from the non-cache plugin dir.
- **Claude Code profiles are deployed by step 5** but never overwrite existing profiles in `~/.claude/profiles/`.
- **All scripts are standalone.** Each script can be run independently (e.g., re-run just the VS Code step without re-running the full `setup.sh`).

## When adding to this repo

- Place macOS-specific files under `macOS/`. If scripts for other platforms are added, create parallel top-level directories (e.g., `linux/`).
- Shell scripts should be plain `sh` or `bash`, executable, and idempotent where possible (re-running them should be safe).
- Configuration files (IDE profiles, terminal profiles, dotfile snippets) should be the raw export format the tool consumes, with personal paths/names replaced by placeholder comments where appropriate.
- Update `README.md` if a new tool or configuration step is added.
