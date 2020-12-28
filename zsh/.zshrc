# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#


if [[ -s "${ZDOTDIR:-$HOME}/.zshenv" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshenv"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s "/usr/share/fzf/key-bindings.zsh" ]]; then
    source "/usr/share/fzf/key-bindings.zsh"
    source "/usr/share/fzf/completion.zsh"
fi


# Change find to fd in fzf

if command -v fd  > /dev/null 2>&1; then

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

fi

# Customize to your needs...

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-g -i -M -R -S -w -z-4 -j4a'


# Handy alias
alias fail="less +F"


# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"


if which pyenv >/dev/null ; then
    eval "$(pyenv virtualenv-init -)"
fi

# Docker goodies

function docker_start_attach () {
    docker start $1 && docker attach $1
}

function drmia () {
    docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}

function newdev () {
    docker run -v $PWD:/usr/src/app -t -i --name $1 -h $1 balkian/devmachine
}

function docker_apply_containers () {
    if [[ "$#" -lt 1 ]];
    then
        echo "Usage: $0 <filter> <action>"
        return
    fi
    containers=$(docker ps -a | grep -v 'CONTAINER' | awk "/$1/{ print \$0}")
    echo -n $containers
    if [[ "$#" -gt 1 ]];
       then
           shift;
           echo $containers | awk '{print $1}' | xargs docker "$@"
    fi
    #| xargs docker rmi "$@"
}

function docker_apply_images () {
    if [[ "$#" -lt 1 ]];
    then
        echo "Usage: $0 <filter> <action>"
        return
    fi
    images=$(docker images -a | grep -v 'REPOSITORY' | awk "/$1/{ print \$0}")
    echo -n $images
    if [[ "$#" -gt 1 ]];
       then
           shift;
           echo $images | awk '{print $3}' | xargs docker "$@"
    fi
    #| xargs docker rmi "$@"
}

function docker_clean_containers () {
    docker rm $(docker ps -q --filter=status=exited)
}

function docker_clean_images () {
    docker rmi $(docker images -a --filter=dangling=true -q)
}

function docker_nuke () {
    docker rmi $(docker images -q)
}

alias da="docker_start_attach"
alias daa="docker_apply_all_containers"
alias dac="docker_apply_containers"
alias dc="docker-compose"
alias dcc="docker_clean_containers"
alias dci="docker_clean_images"
alias dcr="compose-run"
alias dpi="docker images"
alias dps="docker ps"
alias drm="docker rm"
alias drmi="docker rmi"
alias drun="docker run"

alias t="tmux new-session -A -s "


# GSI
alias gsicluster='ssh balkian@shannon.gsi.dit.upm.es -p 1337'      

function gsiclustercopy(){
    scp -P 1337 $1 balkian@shannon.gsi.dit.upm.es:/shared/balkian/$2
}

# Kubernetes (k8s)

alias kg='kubectl --context="kubernetes-admin@kubernetes"'

function kube (){
    if [ "$#" -lt 1 ]; then
        echo "Wrapper for kubectl"
        echo ""
        echo "Usage: $0 <namespace> ... kubectl args"
        return 1
    fi
    context=$1
    shift
    kubectl --context="$context" "$@"
}

function ds () {
    du -xsh "$@" | sort -h

}

function sag () {
    ag -0 -l $1 | xargs -0 sed -ri.bak -e "s/$1/$2/g"
}

# Dircolors for termite

if [[ -s "$HOME/.dircolors" ]]; then
    eval $(dircolors ~/.dircolors)
fi

setopt interactivecomments


export FZFZ_RECENT_DIRS_TOOL=fasd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
