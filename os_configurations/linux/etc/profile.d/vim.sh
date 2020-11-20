p_=/opt/vim/bin
case ":${PATH:-}:" in
    *:$p_:*) ;;
    *) PATH=$p_:$PATH ;;
esac
export PATH
