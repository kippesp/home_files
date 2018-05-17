# .bash_profile - login shells (called one time)

# TODO: mklink - "git bash shell fails to create symbolic links"

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return
[[ "$-" != *i* ]] && return

BASH_PROFILE_WAS_RUN=1

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
			if [ -e $1 ] ; then
				if [ "$2" = "after" ] ; then
					PATH=$PATH:$1
				else
					PATH=$1:$PATH
				fi
			fi
    esac
}

setbashprompt() {
    TITLEPREFIX=$MSYSTEM

    PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]' # set window title
    PS1="$PS1"'\n'                 # new line
    PS1="$PS1"'\[\033[32m\]'       # change to green
    PS1="$PS1"'\u@\h '             # user@host<space>
    PS1="$PS1"'\[\033[35m\]'       # change to purple
    PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
    PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
    PS1="$PS1"'\w'                 # current working directory

	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
	COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
	if test -f "$COMPLETION_PATH/git-prompt.sh"
	then
		. "$COMPLETION_PATH/git-completion.bash"
		. "$COMPLETION_PATH/git-prompt.sh"
		PS1="$PS1"'\[\033[36m\]'  # change color to cyan
		PS1="$PS1"'`__git_ps1`'   # bash function
	fi

    PS1="$PS1"'\[\033[0m\]'        # change color
    PS1="$PS1"'\n'                 # new line
    PS1="$PS1"'$ '                 # prompt: always $
    MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
}


# Add a few directories to PATH
pathmunge $HOME/bin after
pathmunge $HOME/anaconda/bin after
pathmunge /opt/clang+llvm-5.0.0-x86_64-apple-darwin/bin after

pathmunge $HOME/Library/Haskell/bin after

pathmunge /Applications/CoqIDE_8.4pl5.app/Contents/Resources/bin after
pathmunge /Users/kippesp/.emacs.d/lisp/PG/coq after

pathmunge /opt/verilator-3.902/bin after

# MacPorts additions
pathmunge /opt/local/libexec/gnubin
pathmunge /opt/local/bin
pathmunge /opt/local/sbin

export PATH

if [ -e ~/.ccache ] ; then
    export CCACHE_DIR=~/.ccache
fi

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

# Set bash prompt colors (from gitbash)
# if we have the "High Mandatory Level" group, it means we're elevated
#if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
#  then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
#  else _ps1_symbol='\$'
#fi
#[[ $(declare -p PS1 2>/dev/null | cut -c 1-11) = 'declare -x ' ]] || \
#  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
#unset _ps1_symbol

# Fixup git-bash in non login env
#shopt -q login_shell || . /etc/profile.d/git-prompt.sh

# If a login shell, fancify the prompt
# TODO: Fix to help with other platforms
shopt -q login_shell
if [ $? -eq 0 ]; then
    setbashprompt
fi

# User specific aliases and functions
alias less='less -Xm -j.5'

alias gls='git log --stat --decorate --graph --abbrev-commit'

unset -f pathmunge

if [ -e ~/.bash_profile.local ] ; then
    . ~/.bash_profile.local
fi
