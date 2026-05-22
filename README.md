# Setup Development Environment
Scripts and resources that can be used to set up a dev environment

## Quick start (automated)

Run the master setup script to install Homebrew, CLI tools, fonts, and Claude Code:

      ./setup.sh

## Manual installs

* install IDE `VS Code` (preferred)

      https://code.visualstudio.com/

* install java IDE `IntelliJ IDEA`

      https://www.jetbrains.com/idea/download/

* install text editor `Sublime Text`

      https://www.sublimetext.com/

* install git GUI application `SourceTree`

      https://www.sourcetreeapp.com/
      
* install terminal app `Ghostty` (replaces iTerm2)

  Copy config:

      mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
      cp setup_dev_env/macOS/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/

* (legacy) install terminal replacement app `iTerm2`

      https://www.iterm2.com/

* install `docker` desktop app

      https://hub.docker.com/editions/community/docker-ce-desktop-mac
      
* install and configure `Claude Code`

      ./setup_dev_env/macOS/claude_code/install.sh
      
  The install script copies `settings.json` and `hud-config.json` automatically.
  If you need to customize permissions, edit `~/.claude/settings.json` directly
  or use `/config` within Claude Code.

  Set required env vars in your shell profile (`.zprofile` for zsh, `.bash_profile` for bash):

      export GITHUB_PERSONAL_ACCESS_TOKEN="your-github-token"
      export ANTHROPIC_AUTH_TOKEN="your-anthropic-api-key"

## Configure installed software and environment

* install `IntelliJ IDEA` plugins

  - `Lombok Plugin`
  - `BashSupport`
  - `Handlebars/Mustache`
  - `Kubernetes`

* import `IntelliJ IDEA` code style and file template

      ./setup_dev_env/macOS/intellij_idea/GoogleStyle.xml
      ./setup_dev_env/macOS/intellij_idea/FileHeader.txt

* configure `Sublime Text`

  - `Package Control` is built-in on Sublime Text 4 (use Command Palette → Install Package)

  - install plugins
   
    - PrettyJson
    - PrettyYAML
    - Highlighter
    - Indent XML
    - Brackets Color Scheme
    - Flatland Theme
    - SideBarEnhancements
    - Javatar
    - SublimeLinter
    - Terminal
    - FileDiffs
    - Alignment
    - BracketHighlighter
    - Dockerfile Syntax Highlighting
    - YAML Nav
    - Kubernetes Manifest autocomplete
    - sublime-kubernetes-snippets (https://github.com/songjiz/sublime-kubernetes-snippets)
 
 * install `iTerm2` color themes
   
          http://iterm2colorschemes.com/
          
 * configure `vim`
 
          git clone https://github.com/amix/vimrc.git ~/.vim_runtime
          sh ~/.vim_runtime/install_awesome_vimrc.sh
 
 * configure shell profile (`.bash_profile` for bash, `.zprofile`/`.zshrc` for zsh)

  Note: Homebrew paths differ by architecture — `/opt/homebrew` on Apple Silicon, `/usr/local` on Intel.

          export PS1="[\[\e[32m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\W]$ "
          export CLICOLOR=1
          export LSCOLORS=ExFxCxDxBxegedabagacad
          alias ll="ls -l"
          
          [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"


         # generate kubectl bash-completion file
         if [[ (! -e $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl) && (-f $(brew --prefix)/bin/kubectl) ]]; then
            kubectl completion bash > $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
         fi

         if [ -f $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]; then
            . $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
         fi          
          
          
## Useful Applications

* Vnc Viewer

      https://www.realvnc.com/en/connect/download/viewer/
      
* Proxifier

      https://www.proxifier.com/
      
* SQL Developer

      https://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html
      
* JXplorer (LDAP client)

      http://jxplorer.org/

* PostMan

      https://www.getpostman.com/

* Swagger (OPEN API)

      https://swagger.io/
      
* Xnip

      https://xnipapp.com/


