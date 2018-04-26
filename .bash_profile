# .bash_profile - login shells (called one time)

# Added for macos, but probably wasn't necessary
if [[ ${0:0:1} == "-" ]] ; then
    # We're a login shell

    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi

BASH_PROFILE_WAS_RUN=1

# Set PATH
if [ -e $HOME/bin ] ; then
    PATH=$PATH:$HOME/bin
fi
export PATH

if [ -e ~/.ccache ] ; then
    export CCACHE_DIR=~/.ccache
fi
