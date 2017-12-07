#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

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

# Handy aliases
alias fail="less +F"

# Docker goodies
alias da="docker_start_attach"
alias drm="docker rm"
alias drun="docker run"
alias drmi="docker rmi"

alias kg='kubectl --context="kubernetes-admin@kubernetes"'

kube(){
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

TMPPREFIX="${TMPDIR%/}/zsh"

if command -v pyenv >/dev/null 2>&1 ; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    pyenv virtualenvwrapper
fi

setopt interactivecomments
