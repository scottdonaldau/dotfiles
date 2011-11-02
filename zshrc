# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# my homeRC script (linux)
[ -f /home/jobano/scripts/sys-utils/my.bashrc ] && . /home/jobano/scripts/sys-utils/my.bashrc

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="josh"
# oh-my-zsh still: do not check for upgrade by default, it's fucking annoying !
export DISABLE_AUTO_UPDATE="true"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby rails cap github)

source $ZSH/oh-my-zsh.sh

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/sbin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/local/bin:$PATH
export PATH=/opt/bin:$PATH
export JAVA_HOME=/Library/Java/Home
export ANDROID_HOME=~/Library/android-sdk-mac_x86
export PATH=JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
export NODE_PATH=/usr/local/lib/node
export EDITOR=vim

# Customize to your needs...
setopt NOCORRECTALL
[ -f /usr/bin/mvim ] && alias vi='mvim -v' || alias vi='vim'
alias la='ls -A'
alias gd='git diff'
alias gdv='git diff | vim -'
alias be='bundle exec'
alias bake='bundle exec rake'
alias tail='tail -40'

alias ack='ack -a --ignore-dir log --ignore-dir coverage --ignore-dir tmp'

# Glen's @ envato.com git-rebase aliases -- http://notes.envato.com/developers/rebasing-merge-commits-in-git/ -- thanks
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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Added by autojump install.sh
source /etc/profile.d/autojump.sh
