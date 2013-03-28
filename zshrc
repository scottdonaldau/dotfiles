# [non-interactive included] some more aliases
[ -f ${HOME}/scripts/sys-utils/my.rc ] && source ${HOME}/scripts/sys-utils/my.rc

unamestr=`uname`
if [[ "$unamestr" =~ 'Darwin' ]]; then
  # MacOS @Work
  export RHO_HOME=~/.rvm/gems/ruby-1.9.2-p290@rhodes/gems/rhodes-3.2.1
  #export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim" # mvim -v does not work with programs like crontab
  export EDITOR="/usr/bin/mvim"
  export JAVA_HOME=/Library/Java/Home
  export ANDROID_HOME=~/Library/android-sdk-mac_x86
  
  if [[ $TERM_PROGRAM == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]] {
    function chpwd {
      local SEARCH=' '
      local REPLACE='%20'
      local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
      printf '\e]7;%s\a' "$PWD_URL"
    }
    chpwd
  }
else
  # Linux @Home
  export EDITOR="vim"
  source /usr/share/autojump/autojump.zsh
  export JAVA_HOME=/usr/lib/jvm/java-6-sun
  export ANDROID_HOME=~/dev/android-sdk-linux_x86
fi

# fix/stuff the PATH
export PATH=/opt/bin:/opt/local/bin:/usr/local/sbin:/usr/local/bin:$PATH
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

# Quit unless interactive session
[ -z "$PS1" ] && return

# oh-my-zsh configuration
export ZSH=$HOME/.oh-my-zsh
# Set to the name theme to load. (Look in ~/.oh-my-zsh/themes/)
export ZSH_THEME="josh"
# oh-my-zsh still: do not check for upgrade by default, it's fucking annoying !
export DISABLE_AUTO_UPDATE="true"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git bundler autojump)
source $ZSH/oh-my-zsh.sh

# autocomplete commands will include .hidden files
setopt glob_dots

# bind Bash comportment for Ctrl+U (clears beginning of the line)
bindkey \^U backward-kill-line

# Customize to your needs...
setopt NOCORRECTALL
[ -f /usr/bin/mvim ] && alias vi='mvim -v' || alias vi='vim'
alias tail='tail -40'

# git-rebase aliases -- http://notes.envato.com/developers/rebasing-merge-commits-in-git/ -- thanks Glen's @ envato.com
alias grb='git rebase -p'
alias gpull='git fetch origin && grb origin/$(current_branch)'
alias gm='git merge --no-ff'
alias gpnp='gpull && gpush'
# all in one super git stash and do - inspired from Dam5s aliases
alias gsl='git stash list'
alias gspull='git stash && gpull && git stash pop || true'
alias gspnp='gspull && gpush'

# and rvm...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
