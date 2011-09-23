# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="josh"

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
export PATH=~/Library/android-sdk-mac_x86/platform-tools:$PATH
export NODE_PATH=/usr/local/lib/node
export EDITOR=vim

# Customize to your needs...
setopt NOCORRECTALL
alias vi=vim
alias la='ls -A'
alias gd='git diff'
alias gdv='git diff | vim -'
alias be='bundle exec'
alias bake='bundle exec rake'

alias ack='ack -a --ignore-dir log --ignore-dir coverage'
# Glen's @ envato.com git tricks -- http://notes.envato.com/developers/rebasing-merge-commits-in-git/ -- thanks
function git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}
alias gpthis='git push origin HEAD:$(git_current_branch)'
alias grb='git rebase -p'
alias gup='git fetch origin && grb origin/$(git_current_branch)'
alias gm='git merge --no-ff'

alias gupnp='gup && gpthis'

# Damo's git aliases
alias super-gup='git stash && gup && git stash pop'
alias super-gupush='git stash && gup && git stash pop && git push'

#autojump
function autojump_preexec() { (autojump -a "$(pwd -P)"&)>/dev/null }
typeset -ga preexec_functions
preexec_functions+=autojump_preexec
alias jumpstat="autojump --stat"
function j { new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";fi }

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
