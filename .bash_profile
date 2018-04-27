# .bash_profile - login shells (called one time)

BASH_PROFILE_WAS_RUN=1

# Added for macos, but probably wasn't necessary
if [[ ${0:0:1} == "-" ]] ; then
    # We're a login shell

    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
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
pathmunge /opt/local/libexec/gnubin after
pathmunge /opt/local/bin after
pathmunge /opt/local/sbin after
pathmunge /opt/clang+llvm-5.0.0-x86_64-apple-darwin/bin after

export PATH

if [ -e ~/.ccache ] ; then
    export CCACHE_DIR=~/.ccache
fi

if [ -e ~/.bash_profile.local ] ; then
    . ~/.bash_profile.local
fi

unset -f pathmunge
