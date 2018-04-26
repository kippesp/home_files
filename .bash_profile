# .bash_profile - login shells (once)
echo ".bash_profile"
if [[ ${0:0:1} == "-" ]] ; then
    echo "login shell";
fi

#  Should call .bashrc
