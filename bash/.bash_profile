source "$HOME/.bashrc"

if [ "$(tty)" = "/dev/tty1" ]
then
    export XDG_SESSION_TYPE="wayland"
    export XDG_SESSION_DESKTOP="sway"
    export XDG_CURRENT_DESKTOP="sway"
    export QT_QPA_PLATFORM="wayland"
    sway --unsupported-gpu
elif [ "$(tty)" = "/dev/tty2" ]
then
    export XDG_SESSION_DESKTOP="i3"
    export XDG_CURRENT_DESKTOP="i3"
    startx
fi
