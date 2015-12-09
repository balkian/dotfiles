#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='vi'
export VISUAL="myemacs -t"
export ALTERNATE_EDITOR=""
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  ~/.bin
  ~/.local/{bin,sbin}
  $path
)

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
alias drm="docker rm"
alias drun="docker run"
alias drmi="docker rmi"
alias dps="docker ps"
alias dpi="docker images"
alias dc="docker-compose"
alias dcr="compose-run"
function da () {
    docker start $1 && docker attach $1
}
function drmia () {
    docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}
function dca () {
    cmd=$1
    shift
    docker $cmd $(docker ps -q $*)
}
function newdev () {
    docker run -v $PWD:/usr/src/app -t -i --name $1 -h $1 balkian/devmachine
}

alias gsicluster='ssh balkian@shannon.gsi.dit.upm.es -p 1337'      

TMPPREFIX="${TMPDIR%/}/zsh"
