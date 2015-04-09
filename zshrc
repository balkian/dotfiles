export PATH="$PATH:$HOME/.bin/"

# Only update the path if not running interactively
[ -z "$PS1" ] && return
#source ~/.starttmux
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="balkian"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Change this value to set how frequently ZSH updates¬
export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git colored-man virtualenvwrapper cp python wd systemadmin pass)

source $ZSH/oh-my-zsh.sh

#bindkey "^R" history-incremental-search-backward

# Customize to your needs...
autoload -U zmv
alias mmv='noglob zmv -W'
alias e='myemacs -nw'
alias ew='myemacs -n'
export ALTERNATE_EDITOR=/usr/bin/vim EDITOR="vim" VISUAL="vim"

# Docker goodies
alias drm="docker rm"
alias drmi="docker rmi"
alias dps="docker ps"
alias dpi="docker images"
function da () {
    docker start $1 && docker attach $1
}
function drmia () {
    docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}
function drma () {
    docker rm $(docker ps -q $*)
}
function newdev () {
    docker run -v $PWD:/usr/src/app -t -i --name $1 -h $1 balkian/devmachine
}

PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP
ssh-add -l 2>&1 > /dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'; alias mosh='ssh-add -l >/dev/null || ssh-add && unalias mosh; mosh'

### Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin:$HOME/.cabal/bin"

### Virtualenvwrapper
export WORKON_HOME=~/.virtualenvs

setopt extended_glob

### Get RVM to work with zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

### Agent forwarding in tmux too
if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ] ; then
    unlink "$HOME/.ssh/ssh_auth_sock" 2>/dev/null
    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
fi
