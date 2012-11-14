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
plugins=(git ruby rails cap github)
source $ZSH/oh-my-zsh.sh

# bind Bash comportment for Ctrl+U (clears beginning of the line)
bindkey \^U backward-kill-line

# Customize to your needs...
setopt NOCORRECTALL
[ -f /usr/bin/mvim ] && alias vi='mvim -v' || alias vi='vim'
alias la='ls -A'
alias sl=ls # often screw this up
alias gd='git diff'
alias gdv='git diff | vi -'
alias be='bundle exec'
alias bake='bundle exec rake'
alias tail='tail -40'
alias ack='ack -a --ignore-dir log --ignore-dir coverage --ignore-dir tmp --ignore-dir public/assets --ignore-dir public/images'

# git-rebase aliases -- http://notes.envato.com/developers/rebasing-merge-commits-in-git/ -- thanks Glen's @ envato.com
function git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}
alias gpush='git push origin HEAD:$(git_current_branch)'
alias grb='git rebase -p'
alias gpull='git fetch origin && grb origin/$(git_current_branch)'
alias gm='git merge --no-ff'
alias gpnp='gpull && gpush'
# all in one super git stash and do - inspired from Dam5s aliases
alias gsl='git stash list'
alias gspull='git stash && gpull && git stash pop || true'
alias gspnp='gspull && gpush'

# autojump
function autojump_preexec() { (autojump -a "$(pwd -P)"&)>/dev/null }
typeset -ga preexec_functions
preexec_functions+=autojump_preexec
alias jumpstat="autojump --stat"
function j { new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";fi }

# and rvm...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
