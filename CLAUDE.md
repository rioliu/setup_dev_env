# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal macOS development environment setup repository. It contains installation scripts and configuration files to bootstrap a new macOS machine for development work.

## Repo structure

- `README.md` — canonical step-by-step setup guide; covers all manual installs, configuration, and useful applications
- `macOS/install_homebrew.sh` — one-liner script to install Homebrew
- `macOS/install_required_app_by_brew.sh` — installs CLI tools and dev dependencies via Homebrew (git, jq, kubernetes-cli, maven, python3, etc.)
- `macOS/intellij_idea/` — Google code style XML and file header template for IntelliJ IDEA
- `macOS/iterm2/profile.json` — iTerm2 profile export with color scheme, font, and keyboard bindings
- `macOS/claude_code/` — Claude Code setup: install script, settings.json (DeepSeek default + permissions), GLM profile for backend switching

## When adding to this repo

- Place macOS-specific files under `macOS/`. If scripts for other platforms are added, create parallel top-level directories (e.g., `linux/`).
- Shell scripts should be plain `sh` or `bash`, executable, and idempotent where possible (re-running them should be safe).
- Configuration files (IDE profiles, terminal profiles, dotfile snippets) should be the raw export format the tool consumes, with personal paths/names replaced by placeholder comments where appropriate.
- Update `README.md` if a new tool or configuration step is added.
