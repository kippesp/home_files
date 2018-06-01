# .bashrc - called for each interactive, non-login shell/terminal
# (exception, macos) - not called on each terminal invocation

# See: https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ "$BASHRC_WAS_RUN" == "1" ]; then
    echo ".bashrc was run twice"
fi

BASHRC_WAS_RUN=1

# TODO: https://groups.google.com/a/continuum.io/forum/#!topic/anaconda/mWPH_zCAfAg
setbashprompt() {
    TITLEPREFIX=$MSYSTEM

    PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]' # set window title
    PS1="$PS1"'\n'                 # new line
    PS1="$PS1"'\[\033[32m\]'       # change to green
    PS1="$PS1"'\u@\h '             # user@host<space>
    # Used by MSYS/gitbash
    if [ "x" != "x${MSYSTEM}" ]; then
        PS1="$PS1"'\[\033[35m\]'       # change to purple
        PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
    fi
    PS1="$PS1"'\[\033[36m\]'       # change to cyan
    PS1="$PS1"'\w'                 # current working directory

    # See: http://tldp.org/LDP/abs/html/string-manipulation.html
	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    if [ -e $COMPLETION_PATH/contrib ]; then
        # macos - git-scm.com
        COMPLETION_PATH="$COMPLETION_PATH/contrib/completion"
        echo "here"
    else
        # ubuntu - (customized)
        # macports - high sierra
        # windows - gitbash
        COMPLETION_PATH="$COMPLETION_PATH/share/git/contrib/completion"
    fi
	if test -f "$COMPLETION_PATH/git-prompt.sh"
	then
		. "$COMPLETION_PATH/git-completion.bash"
		. "$COMPLETION_PATH/git-prompt.sh"
		PS1="$PS1"'\[\033[1;36m\]'  # change color to cyan
		PS1="$PS1"'`__git_ps1`'   # bash function
	fi

    PS1="$PS1"'\[\033[0m\]'        # change color
    PS1="$PS1"'\n'                 # new line
    PS1="$PS1"'\[\033[1;37m\]'     # change bright white
    PS1="$PS1""$CONDA_PROMPT_MODIFIER"   # add anaconda environment name
    PS1="$PS1"'$'                  # prompt: always $
    PS1="$PS1"'\[\033[0m\]'        # change color
    PS1="$PS1"' '                  # prompt: <space>
    MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
}

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

# enable color support of ls and also add handy aliases
if [ `which dircolors` ]; then
    dircolor=`which dircolors`
    #test -r ~/.dircolors && eval "$($dircolors -b ~/.dircolors)" || eval "$($dircolors -b)"

    # enable "ls" colors if supported
    _=`ls --color=auto > /dev/null 2>&1`
    if [ $? -eq 0 ]; then
        alias ls='ls --color=auto'
    fi

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Set login shell variables
MANPAGER='/usr/bin/less -isrRX'
EDITOR=vim
GREP_OPTIONS=--color

if [ -e ~/.ccache ] ; then
    export CCACHE_DIR=~/.ccache
fi

# If a login shell, fancify the prompt
# TODO: Fix to help with other platforms
#shopt -q login_shell
#if [ $? -eq 0 ]; then
#fi

setbashprompt

# Cleanup
unset -f setbashprompt
