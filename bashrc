# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#osx color terminal
export CLICOLOR=1
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend


# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#Already in bash.bashrc
# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

#$PS0='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS0='${debian_chroot:+($debian_chroot)}\u@\h:\W'

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Set up TERM variables.
# vt100 and xterm have no color in vim (at least on unixs), but if we call them xterm-color, they will.
# (vt100 for F-Secure SSH.)
# This may well be the case for some other terms, so I'm putting them here.
# Also set up a variable to indicate whether to set up the title functions.
# TODO gnome-terminal, or however it reports itself
case $TERM in

screen)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=true
;;

xterm-color|color_xterm|rxvt|Eterm|screen*) # screen.linux|screen-w
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=true
;;

linux)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=false
;;

xterm|vt100)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=true
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=true
;;

*xterm*|eterm|rxvt*)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=true
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=true
;;

*)
    TERM_IS_COLOR=false
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=false
;;

esac

# dircolors... make sure that we have a color terminal, dircolors exists, and ls supports it.
if $TERM_IS_COLOR && ( dircolors --help && ls --color ) &> /dev/null; then
# For some reason, the unixs machines need me to use $HOME instead of ~
# List files from highest priority to lowest.  As soon as the loop finds one that works, it will exit.
    export PROMPT_COMMAND='PS1="\\[\033[1;\`if [[ \$? = "0" ]]; then echo "32m\\]"; else echo "31m\\]"; fi\`☠ \\[\033[0m\]$PS0"'
for POSSIBLE_DIR_COLORS in "$HOME/.dir_colors" "/etc/DIR_COLORS"; do
    [[ -f "$POSSIBLE_DIR_COLORS" ]] && [[ -r "$POSSIBLE_DIR_COLORS" ]] && eval `dircolors -b "$POSSIBLE_DIR_COLORS"` && break
done

alias ls="ls --color=auto"
alias ll="ls --color=auto -l"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
else
# No color, so put a slash at the end of directory names, etc. to differentiate.
alias ll="ls -lF"
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
alias cp="cp -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# Set $TERM for libvte terminals that set $TERM wrong (like gnome-terminal)
{ [ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && {
    if ldd /proc/$PPID/exe | grep libvte; then
    if [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color
    elif [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color
    elif tput -T xterm; then
        TERM=xterm
    fi
    fi
}
} >/dev/null 2>/dev/null


export PYTHONSTARTUP=~/.pythonrc.py

parse_git_branch ()
{
git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#(git::\1)#'
}
#parse_svn_branch() {
#  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / #'{print "(svn::"$1 "/" $2 ")"}'
#}
#parse_svn_url() {
#  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
#}
#parse_svn_repository_root() {
#  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
#}

export EDITOR="vim"

#setWindowTitle() {
#    if [ ! -z "$TMUX" ];then
#        echo -ne "\\033k$*\033\\"
#    fi
#    echo -ne "\e]2;$*\a"
#}
#updateWindowTitle() {
#        setWindowTitle "${HOSTNAME%%.*}:${PWD/$HOME/~}"
#}

# Add git and svn branch names
PS0="$PS0 \\[\033[1;32m\]\$(parse_git_branch)\\[\033[0m\]\$ "
#if [ "$TERM " = "xterm " ]; then
#    export PROMPT_COMMAND="$PROMPT_COMMAND&&updateWindowTitle"
#fi
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=$PATH:"/media/Data/code/personal-scripts/"
export CDPATH=$CDPATH:"/media/Data/"

# TMUX
if which tmux 2>&1 >/dev/null; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux attach
    # when quitting tmux, try to attach
    if test -z ${TMUX}; then
        exit;
    fi
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
