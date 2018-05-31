# .bash_profile - login shells (called one time)

# TODO: mklink - "git bash shell fails to create symbolic links"

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return
[[ "$-" != *i* ]] && return

if [ "$BASH_PROFILE_WAS_RUN" == "1" ]; then
    echo ".bash_profile was run twice"
fi

BASH_PROFILE_WAS_RUN=1

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
pathmunge /opt/clang+llvm-5.0.0-x86_64-apple-darwin/bin after

pathmunge $HOME/Library/Haskell/bin after

pathmunge /Applications/CoqIDE_8.4pl5.app/Contents/Resources/bin after
pathmunge /Users/kippesp/.emacs.d/lisp/PG/coq after

pathmunge /opt/verilator-3.902/bin after

# MacPorts additions
pathmunge /opt/local/libexec/gnubin
pathmunge /opt/local/bin
pathmunge /opt/local/sbin

# MacOS git
pathmunge /usr/local/git/bin

# Anaconda packages (keep at end of PATH)
pathmunge $HOME/anaconda/bin after

export PATH

# TODO - ??macos only?? Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
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

# Enable macport's bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

if [ -e ~/.bash_profile.local ] ; then
    . ~/.bash_profile.local
fi

# Cleanup
unset -f pathmunge
