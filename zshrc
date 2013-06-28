
[ -f ${HOME}/scripts/sys-utils/my.rc ] && source ${HOME}/scripts/sys-utils/my.rc

unamestr=`uname`
if [[ "$unamestr" =~ 'Darwin' ]]; then
  # MacOS @Work
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
  alias md5sum='md5 -r'
  alias sha1sum='openssl sha1'
else
  # Linux @Home
  export JAVA_HOME=/usr/lib/jvm/java-6-sun
  export ANDROID_HOME=~/dev/android-sdk-linux_x86
fi

export EDITOR="vim"

# fix/stuff the PATH
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
export PATH=$HOME/.dotfiles/bin:/opt/bin:/opt/local/bin:/usr/local/sbin:/usr/local/bin:$PATH

# Quit unless interactive session
[ -z "$PS1" ] && return

# oh-my-zsh configuration
export ZSH=$HOME/.oh-my-zsh
# Set to the name theme to load. (Look in ~/.oh-my-zsh/themes/)
export ZSH_THEME="josh"
# oh-my-zsh still: do not check for upgrade by default, it's fucking annoying !
export DISABLE_AUTO_UPDATE="true"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git bundler autojump rbenv)
source $ZSH/oh-my-zsh.sh
zstyle :omz:plugins:ssh-agent id_rsa id_rsa_ffmini

# autocomplete commands will include .hidden files
setopt glob_dots

# bind Bash comportment for Ctrl+U (clears beginning of the line)
bindkey \^U backward-kill-line

# Customize to your needs...
setopt NOCORRECTALL
[ -f /usr/bin/mvim ] && alias vi='mvim -v' || alias vi='vim'

# git kitchen
# git-rebase aliases -- http://notes.envato.com/developers/rebasing-merge-commits-in-git/ -- thanks Glen's @ envato.com
alias grb='git rebase -p'
alias gpull='git fetch origin && grb origin/$(current_branch)'
alias gm='git merge --no-ff'
alias gpnp='gpull && gpush'
# all in one super git stash and do - inspired from Dam5s aliases
alias gsl='git stash list'
alias gspull='git stash && gpull && git stash pop || true'
alias gspnp='gspull && gpush'

