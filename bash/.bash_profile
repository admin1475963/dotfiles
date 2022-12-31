if [ -f ~/.bashrc ]
then
    source "$HOME/.bashrc"
fi

if [ -z $DISPLAY ]
then
   if [ "$(tty)" = "/dev/tty1" ]
   then
       export XDG_CURRENT_DESKTOP="sway"
       export QT_QPA_PLATFORM "wayland"
       exec sway --unsupported-gpu
   elif [ "$(tty)" = "/dev/tty2" ]
   then
       export XDG_CURRENT_DESKTOP="xmonad"
       startx "$HOME/.config/X11/xinitrc" --
    else
        tty
    fi
fi
