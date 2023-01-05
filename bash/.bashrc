source "$HOME/.config/bash/config.sh"

if [[ $(dirname $(tty)) == "/dev/pts" \
          && $(ps --no-header --pid=$PPID --format=comm) != "fish" \
          && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi
