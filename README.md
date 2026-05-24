# Agentic Development Environment

An opinionated macOS dev environment that puts an AI coding agent (Claude Code) alongside a modern CLI toolchain, language runtimes, and editor config — so you can ship with either keystrokes or natural language.

## Philosophy

Three layers, each building on the last:

1. **Foundation** — package manager, shell, terminal. The boring stuff that must work.
2. **Toolchain** — CLI tools picked for speed and composability. The agent uses these under the hood (ripgrep for search, fd for file discovery, jq for JSON, git for version control). Fast tools mean fast agent loops.
3. **Agent & Editor** — Claude Code with plugins for the AI side; VS Code with Go/Python language servers for manual editing. Same project, two interfaces.

## Quick start

```sh
./setup.sh
```

Installs Homebrew, CLI tools, fonts, Ghostty, Starship, Claude Code with plugins, and VS Code config.

## What gets installed

### Via setup.sh (automated)

| Layer | Tools |
|---|---|
| Package manager | Homebrew |
| Shell | bash-completion, starship (prompt) |
| Terminal | Ghostty (GPU-accelerated) |
| Core CLI | git, curl, wget, jq, tree, coreutils, nmap, sshpass |
| Modern CLI | ripgrep, fd, bat, lsd, fzf, zoxide, bottom, tlrc, git-delta, lazygit, gh, golangci-lint |
| Languages & tooling | python3, go, uv (Python package manager) |
| Kubernetes | kubectl |
| Fonts | JetBrainsMono, DroidSansMono, Hack, Maple Mono — all Nerd Font variants |
| Claude Code | CLI + 4 plugins (context7, claude-hud, karpathy-skills, skill-creator) |
| VS Code | Installed via brew cask, 16 Go/Python extensions, additively merged settings |

### Manual

| Tool | Purpose |
|---|---|
| Podman Desktop | Container management (Docker alternative) — `brew install --cask podman-desktop` |
| vim | `git clone https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh` |

## The agent stack

Claude Code is the centerpiece. It reads/writes files, runs shell commands, searches code, and manages git — all from the terminal.

### Plugins

| Plugin | What it does |
|---|---|
| `context7` | Real-time library documentation (replaces stale training data) |
| `claude-hud` | Status bar with tools, agents, todos, and timers |
| `karpathy-skills` | Behavioral guardrails to reduce common LLM coding mistakes |
| `skill-creator` | Build and iterate on custom skills |

GitHub interactions (PRs, issues, search) are handled via the `gh` CLI instead of a plugin — faster, no MCP tool overhead in context.

### Permissions

`macOS/claude_code/settings.json` pre-allows safe read-only and git operations so the agent doesn't prompt for every `ls` or `grep`. Destructive operations still require approval.

### Custom model profiles

Default routes through Anthropic. Copy `macOS/claude_code/profiles/glm.json` to `~/.claude/profiles/` if you use a third-party endpoint, or create your own.

### Environment variables

Set in your shell profile:

```sh
export GITHUB_PERSONAL_ACCESS_TOKEN="your-github-token"
export ANTHROPIC_AUTH_TOKEN="your-anthropic-api-key"
```

## VS Code

Extensions and settings are applied to the **default profile** via `macOS/vscode/install_extensions.sh` (called automatically by `setup.sh`):

- **Extensions** are installed via `code --install-extension`, skipping already-installed ones
- **Settings** are additively merged — only keys from the repo's `settings.json` that don't already exist are added. Existing settings are never overwritten

VS Code is installed via `brew install --cask visual-studio-code` if not already present.

### Go

```json
"[go]": {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": { "source.organizeImports": "explicit" }
},
"go.lintTool": "golangci-lint",
"go.toolsManagement.autoUpdate": true
```

First time opening a `.go` file, the Go extension will prompt to install `gopls`, `dlv`, and `golangci-lint`. Accept it.

### Python

```json
"[python]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-python.python"
},
"python.languageServer": "Pylance",
"python.analysis.typeCheckingMode": "basic",
"python.testing.pytestEnabled": true
```

## Terminal (Ghostty)

GPU-accelerated, config at `macOS/ghostty/config`. Copy it into place:

```sh
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
cp macOS/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/
```

Key settings: Maple Mono NF CN at 13px, dark theme with 80% opacity, 130×50 window, 10k-line scrollback. iTerm2 profile is kept as a legacy fallback at `macOS/iterm2/profile.json`.

## Shell prompt (Starship)

Config at `macOS/starship/starship.toml`. Copy it into place:

```sh
mkdir -p ~/.config
cp macOS/starship/starship.toml ~/.config/starship.toml
```

Shows OS, user, path, git branch/status, active language runtimes (Go, Python, Rust, Node, Java, etc.), and command duration. Catppuccin Mocha palette.

## Shell profile

Add to `~/.zshrc`:

```sh
# Homebrew bash completion
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# kubectl completion
if [[ ! -e $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]] && [[ -f $(brew --prefix)/bin/kubectl ]]; then
  kubectl completion bash > $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
fi
[[ -f $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]] && . $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
```

## Design decisions

- **No Docker Desktop.** Podman Desktop — no license fees, daemonless.
- **uv over pip.** Faster resolution, lock files, simpler virtualenv management.
- **Ghostty over iTerm2.** Modern renderer, simpler config, native performance.
- **Starship over hand-rolled PS1.** One config file, language-aware, consistent across shells.
- **Nerd Fonts over plain monospace.** Icons in prompt and file tree (lsd, starship) need them.
- **Settings merge, not overwrite.** VS Code settings are applied additively — local tweaks survive re-provisioning.

## Useful applications

- **VNC Viewer** — https://www.realvnc.com/en/connect/download/viewer/
- **Proxifier** — https://www.proxifier.com/
- **SQL Developer** — https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html
- **JXplorer** (LDAP client) — http://jxplorer.org/
- **Postman** — https://www.getpostman.com/
- **Swagger** — https://swagger.io/
- **Xnip** (screenshot) — https://xnipapp.com/
