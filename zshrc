# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify share_history
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/balkian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors
colors
setopt prompt_subst

local smiley="%B%(?,%{$fg[green]%}☠%{$reset_color%},%{$fg[red]%}☠%{$reset_color%})%b"
PS0='${debian_chroot:+($debian_chroot)}%n@%M'

parse_git_branch()
{
git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#(git::\1)#'
}

if ( dircolors --help && ls --color ) &> /dev/null; then
# For some reason, the unixs machines need me to use $HOME instead of ~
# List files from highest priority to lowest.  As soon as the loop finds one that works, it will exit.
function precmd {
PROMPT="%~ %{$fg[green]%}%B$(parse_git_branch)%b%{$reset_color%}
${smiley} $PS0: ";
RPROMPT="%T";
}

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
## Completions
#autoload -U compinit
#compinit -C
#
### case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
       'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

bindkey -M vicmd 'r' history-incremental-search-backward

# TMUX
# if [[ -z "$KONSOLE_DBUS_SERVICE" & `which tmux` ]]; then
         # if no session is started, start a new session
         if [[ -z "$KONSOLE_DBUS_SERVICE" && -n $(which tmux) ]]; then
     stty -ixon
     test -z ${TMUX} && tmux attach
     # when quitting tmux, try to attach
     if [[ -z ${TMUX} ]]; then
         exit;
     fi
 fi

