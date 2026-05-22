# Setup Development Environment

Bootstrap a new macOS machine for development.

## Quick start

      ./setup.sh

Installs Homebrew, CLI tools, fonts, Ghostty, and Claude Code with plugins.

## Manual installs

**VS Code** — https://code.visualstudio.com/

**Sublime Text** — https://www.sublimetext.com/

**SourceTree** (Git GUI) — https://www.sourcetreeapp.com/

**Podman Desktop** (container management, replaces Docker Desktop):

      brew install --cask podman-desktop

**Ghostty** (terminal, replaces iTerm2) — installed by `setup.sh`. Copy config:

      mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
      cp macOS/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/

**iTerm2** (legacy) — https://www.iterm2.com/

## Claude Code

Installed by `setup.sh` with plugins (github, context7, claude-hud, karpathy-skills, skill-creator).
Configs (`settings.json`, `hud-config.json`) are copied automatically.

Set env vars in your shell profile:

      export GITHUB_PERSONAL_ACCESS_TOKEN="your-github-token"
      export ANTHROPIC_AUTH_TOKEN="your-anthropic-api-key"

## Shell profile

Add to `~/.zshrc` (or `~/.bash_profile` for bash). Homebrew path differs by architecture: `/opt/homebrew` (Apple Silicon) or `/usr/local` (Intel).

      export PS1="[\[\e[32m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\W]$ "
      export CLICOLOR=1
      export LSCOLORS=ExFxCxDxBxegedabagacad
      alias ll="ls -l"

      [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

      # kubectl completion
      if [[ ! -e $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]] && [[ -f $(brew --prefix)/bin/kubectl ]]; then
        kubectl completion bash > $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
      fi
      [[ -f $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]] && . $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl

## vim

      git clone https://github.com/amix/vimrc.git ~/.vim_runtime
      sh ~/.vim_runtime/install_awesome_vimrc.sh

## Sublime Text plugins

Package Control is built-in on Sublime Text 4. Install via Command Palette:

PrettyJson, PrettyYAML, Highlighter, Indent XML, Brackets Color Scheme, Flatland Theme, SideBarEnhancements, SublimeLinter, Terminal, FileDiffs, Alignment, BracketHighlighter, Dockerfile Syntax Highlighting, YAML Nav, Kubernetes Manifest autocomplete, [sublime-kubernetes-snippets](https://github.com/songjiz/sublime-kubernetes-snippets)

## iTerm2 color themes

http://iterm2colorschemes.com/

## Useful applications

- **VNC Viewer** — https://www.realvnc.com/en/connect/download/viewer/
- **Proxifier** — https://www.proxifier.com/
- **SQL Developer** — https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html
- **JXplorer** (LDAP client) — http://jxplorer.org/
- **Postman** — https://www.getpostman.com/
- **Swagger** — https://swagger.io/
- **Xnip** (screenshot) — https://xnipapp.com/
