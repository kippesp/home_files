# .bashrc - called for each interactive, non-login shell/terminal
# (exception, macos) - not called on each terminal invocation

echo "Sourcing .bashrc"

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ "$BASHRC_WAS_RUN" == "1" ]; then
    echo ".bashrc was run twice"
fi

BASHRC_WAS_RUN=1

# check the window size after each Bash command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the Bash history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
unset HISTFILESIZE
HISTSIZE=1000000
PROMPT_COMMAND="history -a"

# User specific aliases and functions
alias less='less -Xm -j.5'
alias gls='git log --stat --decorate --graph --abbrev-commit'

# Set login shell variables
MANPAGER='/usr/bin/less -isrRX'
#export PS1="\[\e]0;\u@\h: \w\a\]\u@\h:\w\$ "
EDITOR=vim
GREP_OPTIONS=--color
