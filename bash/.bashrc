source "$HOME/.profile"

if [[ $(dirname $(tty)) == "/dev/pts" \
          && $(ps --no-header --pid=$PPID --format=comm) != "fish" \
          && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi


