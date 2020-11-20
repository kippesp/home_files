p_=/opt/cmake/current/bin
case ":${PATH:-}:" in
    *:$p_:*) ;;
    *) PATH=$p_:$PATH ;;
esac
export PATH
