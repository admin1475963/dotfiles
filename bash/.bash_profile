source "$HOME/.bashrc"

if [ "$(tty)" = "/dev/tty2" ]
then
    startx
elif [ "$(tty)" = "/dev/tty3" ]
then
    export QT_QPA_PLATFORM="wayland;xcb"
    sway --unsupported-gpu
fi
