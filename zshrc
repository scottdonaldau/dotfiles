unamestr=`uname`
if [[ "$unamestr" =~ 'Darwin' ]]; then
  # MacOS @Work
  export JAVA_HOME=/Library/Java/Home
  export ANDROID_HOME=~/Library/android-sdk-mac_x86
  export NODEJS=/usr/local/share/npm
  export PATH=$NODEJS/bin:$PATH

  # Keypad from USB keyboard needs help under zsh since Yosemite (10.10) update
  # thx Robin Daugherty - http://superuser.com/a/830850/91702
  # 0 . Enter
  bindkey -s "^[Op" "0"
  bindkey -s "^[On" "." 
  bindkey -s "^[OM" "^M"
  # 1 2 3
  bindkey -s "^[Oq" "1"
  bindkey -s "^[Or" "2"
  bindkey -s "^[Os" "3"
  # 4 5 6
  bindkey -s "^[Ot" "4"
  bindkey -s "^[Ou" "5"
  bindkey -s "^[Ov" "6"
  # 7 8 9
  bindkey -s "^[Ow" "7"
  bindkey -s "^[Ox" "8"
  bindkey -s "^[Oy" "9"
  # + -  * /
  bindkey -s "^[Ol" "+"
  bindkey -s "^[Om" "-"
  bindkey -s "^[Oj" "*"
  bindkey -s "^[Oo" "/"

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
  export JAVA_HOME=/usr/lib/jvm/java-6-sun
  export ANDROID_HOME=~/dev/android-sdk-linux_x86
fi

export EDITOR="vim"

# fix/stuff the PATH
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
export PATH=$HOME/.dotfiles/bin:/usr/local/sbin:/usr/local/bin:$PATH

# Quit unless interactive session
[ -z "$PS1" ] && return

# oh-my-zsh configuration
export ZSH=$HOME/.oh-my-zsh
# Set to the name theme to load. (Look in ~/.oh-my-zsh/themes/)
export ZSH_THEME="josh"
# oh-my-zsh still: do not check for upgrade by default, it's fucking annoying !
export DISABLE_AUTO_UPDATE="true"
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git bundler autojump rbenv ssh-agent)
source $ZSH/oh-my-zsh.sh
zstyle :omz:plugins:ssh-agent id_rsa id_rsa_ffmini id_rsa_test id_rsa_ldellou

# autocomplete commands will include .hidden files
setopt glob_dots


# bind Bash comportment for Ctrl+U (clears beginning of the line)
bindkey \^U backward-kill-line

# Customize to your needs...
setopt NOCORRECTALL

# load more machine specific scripts at load
[ -f ${HOME}/scripts/sys-utils/my.rc ] && source ${HOME}/scripts/sys-utils/my.rc

# load aliases scripts if defined
alias_dir=${HOME}/.aliases; [ -d $alias_dir ] && for i in `ls $alias_dir`; do source $alias_dir/$i; done

