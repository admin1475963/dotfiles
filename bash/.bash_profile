source "$HOME/.config/bash/config.sh"

if [ -z $DISPLAY ]
then
   if [ "$(tty)" = "/dev/tty1" ]
   then
       export XDG_CURRENT_DESKTOP="sway"
       exec sway --unsupported-gpu
   elif [ "$(tty)" = "/dev/tty2" ]
   then
       export XDG_CURRENT_DESKTOP="xmonad"
       startx "$HOME/.config/X11/xinitrc" --
   fi
else
    source "$HOME/.bashrc"
fi
