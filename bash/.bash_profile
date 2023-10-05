source "$HOME/.bashrc"

if [ "$(tty)" = "/dev/tty1" ]
then
    startx
elif [ "$(tty)" = "/dev/tty2" ]
then
    export QT_QPA_PLATFORM="wayland;xcb"
    export _JAVA_AWT_WM_NONREPARENTING=1
    sway --unsupported-gpu
fi
