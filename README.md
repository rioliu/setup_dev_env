# Agentic Development Environment

An opinionated macOS dev environment that puts an AI coding agent (Claude Code) alongside a modern CLI toolchain, language runtimes, and editor config — so you can ship with either keystrokes or natural language.

## Step-by-step setup

### Prerequisites

```sh
xcode-select --install
```

Accept the license dialog. This installs the C compiler and Git that Homebrew needs.

### 1. Clone and run

```sh
git clone git@github.com:rioliu/setup_dev_env.git
cd setup_dev_env
./setup.sh
```

`setup.sh` runs five steps, each idempotent (safe to re-run):

| Step | What it does |
|---|---|
| 1 — Homebrew | Installs the package manager (skips if present) |
| 2 — CLI tools & apps | Installs git, ripgrep, fd, bat, jq, fzf, zoxide, starship, gh, ghostty, fonts, etc. |
| 3 — Claude Code | Installs CLI + 4 plugins, merges settings into `~/.claude/settings.json` |
| 4 — VS Code | Installs VS Code + 16 extensions, additively merges settings |
| 5 — Configs | Deploys Ghostty, Starship, and Claude profile configs |

### 2. Shell profile

Add to `~/.zprofile` (API keys — loaded once at login):

```sh
export ANTHROPIC_AUTH_TOKEN="your-anthropic-key"
export GITHUB_PERSONAL_ACCESS_TOKEN="your-github-token"
# If using the GLM profile:
export ZHIPU_API_KEY="your-zhipu-key"
```

Add to `~/.zshrc` (CLI tool init — loaded every shell):

```sh
# Starship prompt
eval "$(starship init zsh)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf keybindings
eval "$(fzf --zsh)"

# Homebrew bash completion
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# kubectl completion
if [[ ! -e $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]] && [[ -f $(brew --prefix)/bin/kubectl ]]; then
  kubectl completion bash > $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
fi
[[ -f $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]] && . $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
```

Then reload:

```sh
source ~/.zshrc
```

### 3. Optional tools

```sh
# Container management (Docker alternative)
brew install --cask podman-desktop

# Vim config
git clone https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
```

### 4. Verify

| Check | Command | Expected |
|---|---|---|
| Homebrew | `brew --version` | version string |
| CLI tools | `rg --version && fd --version && bat --version` | three version strings |
| Starship | open a new shell tab | Catppuccin Mocha prompt with git info |
| Ghostty | open Ghostty app | Gruvbox Dark Hard theme, Maple Mono font |
| Claude Code | `claude --version && claude plugins list` | shows context7, claude-hud, karpathy-skills, skill-creator |
| VS Code | `code --list-extensions \| wc -l` | >= 16 |
| Claude profile | `ls ~/.claude/profiles/` | `glm.json` |

## What gets installed

### Automated (via setup.sh)

| Layer | Tools |
|---|---|
| Package manager | Homebrew |
| Shell | bash-completion, starship (prompt) |
| Terminal | Ghostty (GPU-accelerated) |
| Core CLI | git, curl, wget, jq, tree, coreutils, nmap |
| Modern CLI | ripgrep, fd, bat, lsd, fzf, zoxide, bottom, tlrc, git-delta, lazygit, gh |
| Languages & tooling | python, uv, golangci-lint |
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

GitHub interactions (PRs, issues, search) default to the `gh` CLI — faster, lower token overhead. The GitHub MCP plugin is a fallback for operations that `gh` doesn't support yet.

### Permissions

`macOS/claude_code/settings.json` configures `permissions.defaultMode: "auto"`, which skips all permission prompts. The `permissions.allow` list is a **fallback** — if you switch back to `"default"` mode (via `/config`), pre-approved safe operations (read-only, git) won't prompt. Destructive operations still require approval in default mode.

### Custom model providers

Default routes through Anthropic. To switch to a different provider, edit `~/.claude/settings.json` and add an `env` block.

`setup.sh` (step 5) deploys reference templates from `macOS/claude_code/profiles/` to `~/.claude/profiles/` so you can copy the `env` block from. Existing files are never overwritten.

**To switch from Anthropic to GLM:**

1. Open the template: `cat ~/.claude/profiles/glm.json`
2. Copy its `env` block into your `~/.claude/settings.json`:
   ```json
   {
     "permissions": { "...": "..." },
     "env": {
       "ANTHROPIC_BASE_URL": "https://open.bigmodel.cn/api/anthropic",
       "ANTHROPIC_AUTH_TOKEN": "${ZHIPU_API_KEY}",
       "ANTHROPIC_MODEL": "opus",
       "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-5.1",
       "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-5-turbo",
       "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.5-air",
       "CLAUDE_CODE_SUBAGENT_MODEL": "glm-4.5-air",
       "API_TIMEOUT_MS": "3000000",
       "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": 1
     }
   }
   ```
3. Make sure `ZHIPU_API_KEY` is exported in your `~/.zprofile`
4. Restart Claude Code

**To switch back to Anthropic:** delete the `env` block (or just `ANTHROPIC_BASE_URL` and `ANTHROPIC_AUTH_TOKEN`) from `~/.claude/settings.json`. Claude Code will fall back to OAuth or `ANTHROPIC_API_KEY`.

For details on which env vars control what, see [Claude Code → Model configuration](https://code.claude.com/docs/en/model-config).

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

GPU-accelerated, config at `macOS/ghostty/config`. Deployed automatically by `setup.sh` (step 5).

Key settings: Maple Mono NF CN at 13px, Gruvbox Dark Hard theme, 130x50 window, 10k-line scrollback. iTerm2 profile is kept as a legacy fallback at `macOS/iterm2/profile.json`.

## Shell prompt (Starship)

Config at `macOS/starship/starship.toml`. Deployed automatically by `setup.sh` (step 5).

Shows OS, user, path, git branch/status, active language runtimes (Go, Python, Rust, Node, Java, etc.), and command duration. Catppuccin Mocha palette.

## Design decisions

- **No Docker Desktop.** Podman Desktop — no license fees, daemonless.
- **uv over pip.** Faster resolution, lock files, simpler virtualenv management.
- **Ghostty over iTerm2.** Modern renderer, simpler config, native performance.
- **Starship over hand-rolled PS1.** One config file, language-aware, consistent across shells.
- **Nerd Fonts over plain monospace.** Icons in prompt and file tree (lsd, starship) need them.
- **Settings merge, not overwrite.** VS Code and Claude Code settings are applied additively — local tweaks survive re-provisioning.

## Useful applications

- **VNC Viewer** — https://www.realvnc.com/en/connect/download/viewer/
- **Proxifier** — https://www.proxifier.com/
- **SQL Developer** — https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html
- **JXplorer** (LDAP client) — http://jxplorer.org/
- **Postman** — https://www.getpostman.com/
- **Swagger** — https://swagger.io/
- **Xnip** (screenshot) — https://xnipapp.com/
