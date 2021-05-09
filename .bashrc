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

    # Used for my chroot environments (Linux)
    if [ -e /.chroot ]; then
        PS1="$PS1"'\[\033[31m\]'       # change to red
        CHROOT_NAME=`cat /.chroot | awk '{printf $1}'`
        PS1="$PS1"'chroot:'
        PS1="$PS1"'\[\033[1;31m\]'     # change to bright red
        PS1="$PS1"'$CHROOT_NAME '      # show MSYSTEM
    fi
    PS1="$PS1"'\[\033[36m\]'       # change to cyan
    PS1="$PS1"'\w'                 # current working directory

    # See: http://tldp.org/LDP/abs/html/string-manipulation.html
    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    if [ -e "$COMPLETION_PATH/contrib" ]
    then
        # macos - git-scm.com
        COMPLETION_PATH="$COMPLETION_PATH/contrib/completion"
    elif [ -e "$COMPLETION_PATH/share/git/completion" ]
    then
        # windows - gitbash
        COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    elif [ -e /opt/git.git/contrib/completion ]
    then
        # custom linux - manual clone of repo (but no installation)
        COMPLETION_PATH="/opt/git.git/contrib/completion"
    #else
    #    # ubuntu - (customized) "ln -s /opt/git.git/contrib /usr/share/git"
    #    # macports - high sierra - /Applications/Xcode.app/Contents/Developer/usr/share/git/contrib/completion
    #    # windows - gitbash
    #    #COMPLETION_PATH="$COMPLETION_PATH/share/git/contrib/completion"
    #    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    fi

    # Configure git-ified bash prompt
    if test -f "$COMPLETION_PATH/git-prompt.sh"
    then
        . "$COMPLETION_PATH/git-completion.bash"
        . "$COMPLETION_PATH/git-prompt.sh"
        PS1="$PS1"'\[\033[1;36m\]'          # change color to cyan
        PS1="$PS1"'`__git_ps1`'             # bash function

        # Disable a few niceties when using msysgit's bash
        if [ ! -e ~/.simple_bash_prompt ]
        then
            GIT_PS1_SHOWDIRTYSTATE=1            # enable dirty indicator
            GIT_PS1_SHOWSTASHSTATE=1            # enable stash empty indicator
            GIT_PS1_SHOWUPSTREAM='verbose '     # show upstream count delta
            GIT_PS1_SHOWUPSTREAM+='name'        # show tracking branch name
        fi
    fi

    PS1="$PS1"'\[\033[0m\]'        # change color
    PS1="$PS1"'\n'                 # new line
    PS1="$PS1"'\[\033[1;37m\]'     # change bright white
    #PS1="$PS1""${CONDA_PROMPT_MODIFIER}"   # add anaconda environment name
    PS1="$PS1"'$'                  # prompt: always $
    PS1="$PS1"'\[\033[0m\]'        # change color
    PS1="$PS1"' '                  # prompt: <space>
    MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
}

# ls, but only for directories
lsdirs () {
    /bin/ls -l $1 | grep ^d | awk '{print $9}'
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

# Expand aliased sudo-ed command
alias sudo='sudo '

# User specific aliases
alias less='less -Xm -j.5'
alias grepunicode='grep --color=auto -n "[^ -~[:space:]]"'

# User specific aliases - git
alias gls='git log --stat --decorate --graph --abbrev-commit'
alias glsf='git log --stat --decorate --graph --abbrev-commit --pretty=fuller'
alias glsw='git log --stat --decorate --graph --abbrev-commit --stat-width=120'
alias gss='git status -s'
alias glo='git log --graph --format="%C(auto) %h %aE %d %s"'
alias glist='git show --pretty="" --name-only'

# Compiler tools
function dot2pdf {
    if [ "$1" = "" ] ; then
        echo Usage: dos2pdf FILE
        return
    fi

    if [ ! -e "$1" ] ; then
        echo File not found
        return
    fi

    dot -Tpdf $1 -o ${1%.dot}.pdf
}

# enable git colors if available
_=`grep --color=auto --version > /dev/null 2>&1`
if [ $? -eq 0 ]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# programmer aliases
# cfng - C/C++ function grep
#grep --include="*.cpp" -nr "getInstruction()"

# configure ls coloring
_=`ls --color=auto / > /dev/null 2>&1`
if [ $? -eq 0 ]; then
    alias ls='ls --color=auto'

    # try to use the vivid LS_COLORS manager
    _=`vivid generate snazzy > /dev/null 2>&1`
    if [ $? -eq 0 ]; then
        export LS_COLORS="$(vivid generate snazzy)"
    else
        _=`dircolors --version / > /dev/null 2>&1`
        if [ $? -eq 0 ]; then
            eval `dircolors`
        fi
    fi
else
    # fallback to LSCOLORS
    export CLICOLOR=1

    # a WIP - https://geoff.greer.fm/lscolors
    export LSCOLORS=EaGacxdxCaegedadagacad
fi

# replace man pager
_=`less --version > /dev/null 2>&1`
if [ $? -eq 0 ]; then
    export MANPAGER='/usr/bin/less -isrRX'
fi

# specify vim as preferred editor
export EDITOR=vim

if [ -e ~/.ccache ] ; then
    export CCACHE_DIR=~/.ccache
fi

# fixup for Windows mingw terminal applications
if [ "$SYSOS" == "mingw" ]; then
    alias python='winpty python'
fi

# if git configured with a key, support using it
grep -q signingkey ~/.gitconfig
if [ $? -eq 0 ]; then
    export GPG_TTY=$(tty)
fi

# If a login shell, fancify the prompt
# TODO: Fix to help with other platforms
#shopt -q login_shell
#if [ $? -eq 0 ]; then
#fi

setbashprompt

# Cleanup
unset -f setbashprompt
