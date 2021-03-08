# .bash_profile - login shells (called one time)

# TODO: mklink - "git bash shell fails to create symbolic links"

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return
[[ "$-" != *i* ]] && return

# Determine OS type
uname_str="$(uname -s)"
case "${uname_str}" in
    Linux*)     sysos=linux;;
    Darwin*)    sysos=macos;;
    CYGWIN*)    sysos=cygwin;;
    MINGW*)     sysos=mingw;;
    *)          sysos="UNKNOWN:${uname_str}"
esac
export SYSOS=$sysos

# Prevent PATH from being sorted when using tmux on macos (via /usr/libexec/path_helper)
# See: https://superuser.com/questions/544989/does-tmux-sort-the-path-variable
# - Sorting the path causes issues with switching between git and Xcode-git
#   and with macport's python (3) version selector method
# - May want to look at double sourcing on macos
if [ "$SYSOS" == "macos" ] && [ -n "$TMUX" ] && [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

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
pathmunge $HOME/usr/bin after
pathmunge /opt/bin

# Haskell additions
pathmunge $HOME/.ghcup/bin
pathmunge $HOME/.cabal/bin

pathmunge /Applications/CoqIDE_8.4pl5.app/Contents/Resources/bin after
pathmunge /Users/kippesp/.emacs.d/lisp/PG/coq after

pathmunge /opt/verilator-3.902/bin after

# MacPorts additions
pathmunge /opt/local/libexec/gnubin
pathmunge /opt/local/bin
pathmunge /opt/local/sbin

# Local (macos) Python installations
pathmunge $HOME/Library/Python/3.7/bin

# MacOS git
pathmunge /usr/local/git/bin

# Local LLVM
pathmunge /opt/clang+llvm-7.0.0-x86_64-apple-darwin/bin after
pathmunge /opt/clang+llvm-6.0.0-x86_64-apple-darwin/bin after
pathmunge /opt/clang+llvm-5.0.0-x86_64-apple-darwin/bin after
pathmunge /opt/llvm-6.0.0/bin
pathmunge $HOME/usr/opt/llvm-latest/bin

# Local cmake
pathmunge $HOME/usr/opt/cmake-3.18.1/bin

# Anaconda/miniconda/pipenv packages
# Place at end to prevent clash with python3-pkginfo's pkginfo (ubuntu)
# Continue to use "source activate ENV_NAME"
pathmunge $HOME/miniconda3/bin after

# Verilator
pathmunge /opt/verilator/bin after

# Yarn-installed binaries
pathmunge $HOME/.yarn/bin after

# Python packages on macos
pathmunge $HOME/Library/Python/3.8/bin

export PATH

# TODO - ??macos only?? Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Enable macport's bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

if [ -e ~/.bash_profile.local ] ; then
    . ~/.bash_profile.local
fi

# Linux: Hook in a project script for each tmux window when starting tmux with
# a script like the following
# (source: https://stackoverflow.com/questions/20701757/tmux-setting-environment-variables-for-sessions)
# Macos: Doesn't have this issue
#!/bin/sh
#        BAR=/path/to/project/script/file.sh
#        SESSION_NAME="mysession"
#        tmux new-session -s $SESSION_NAME \; \
#            setenv TMUX_SESSION_HOOK $BAR \; \
#            send-keys -t 0 "export TMUX_SESSION_HOOK="$BAR C-m \; \
#            send-keys -t 0 '. $TMUX_SESSION_HOOK' C-m \;
if [ "$TMUX_SESSION_HOOK" != "" ]; then
    . $TMUX_SESSION_HOOK
fi

# Cleanup
unset -f pathmunge
