# Setup Development Environment
Project contains the scripts/resources can be used to setup dev environment

## install required softwares

* install `java 8`

      http://download.oracle.com/otn/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-macosx-x64.dmg

* install `homebrew`

      ./setup_dev_env/macOS/install_homebrew.sh

* install `homebrew` apps

      ./setup_dev_env/macOS/install_required_app_by_brew.sh
      
* install java IDE `IntelliJ IDEA`

      https://www.jetbrains.com/idea/download/download-thanks.html?platform=mac&code=IIC

* install text editor `Sublime Text 3`
    
      https://download.sublimetext.com/Sublime%20Text%20Build%203176.dmg

* install git GUI application `SourceTree`

      https://www.sourcetreeapp.com/
      
* install terminal replacement app `iTerm2`

      https://www.iterm2.com/

* install `docker` desktop app

      https://hub.docker.com/editions/community/docker-ce-desktop-mac
      
## Configure install software and env

* install `IntelliJ IDEA` plugins

  - `Lombok PLugin`
  - `BashSupport`
  - `Handlebars/Mustache`

* import `IntelliJ IDEA` code style and file template

      ./setup_dev_env/macOS/intellij_idea/GoogleStyle.xml
      ./setup_dev_env/macOS/intellij_idea/FileHeader.txt

* configure `Sublime Text 3` 

  - install `Package Control`
      
    The console is accessed via the ctrl+` shortcut or the View > Show Console menu.
    
        import urllib.request,os,hashlib; h = 'df21e130d211cfc94d9b0905775a7c0f' + '1e3d39e33b79698005270310898eea76'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
   
   - install plugins
   
   ```PrettyJson
    PrettyYAML
    Highlighter
    Indent XML
    Brackets Color Scheme
    Flatland Theme
    SideBarEnhancements
    Javatar
    SublimeLinter
    Terminal
    FileDiffs
    Alignment
    BracketHighlighter
    Dockerfile Syntax Highlighting
    YAML Nav
 
 * install `iTerm2` color themes
   
          http://iterm2colorschemes.com/
          
 * configure `vim`
 
          git clone https://github.com/amix/vimrc.git ~/.vim_runtime
          sh ~/.vim_runtime/install_awesome_vimrc.sh
 
 * configure ~/.bash_profile
 
          export PS1="[\u@\h \W]\$ "
          export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
          export CLICOLOR=1
          export LSCOLORS=ExFxCxDxBxegedabagacad
          alias ll="ls -l"
          
          if [ -f $(brew --prefix)/etc/bash_completion ]; then
              source $(brew --prefix)/etc/bash_completion
          fi
          
          # generate kubectl bash-completion file
          if [ ! -e $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl ]; then
              kubectl completion bash > $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
          fi
          
          source  $(brew --prefix bash-completion)/etc/bash_completion.d/kubectl
          
## Useful Applications
* Vnc Viewer

https://www.realvnc.com/en/connect/download/viewer/
