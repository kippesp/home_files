# .bash_profile - login shells (called one time)

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# User specific aliases and functions
alias less='less -Xm -j.5'

alias gls='git log --stat --decorate --graph --abbrev-commit'

unset -f pathmunge

if [ -e ~/.bash_profile.local ] ; then
    . ~/.bash_profile.local
fi
