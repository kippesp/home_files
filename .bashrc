# .bashrc - interactive, non-login shell
# (exception, macos) - not called on each terminal invocation

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

BASHRC_WAS_RUN=1

alias gls='git log --stat --decorate --graph --abbrev-commit'

# Bash stuff
shopt -s checkwinsize
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000000
HISTFILESIZE=2000000
