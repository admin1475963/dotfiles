source "$HOME/.config/bash/config.sh"

if [ -z $DISPLAY ]
then
   if [ "$(tty)" = "/dev/tty1" ]
   then
       export XDG_SESSION_DESKTOP="sway"
       export XDG_CURRENT_DESKTOP="sway"
       #export QT_QPA_PLATFORM="wayland"
       exec sway --unsupported-gpu
   elif [ "$(tty)" = "/dev/tty2" ]
   then
       export XDG_SESSION_DESKTOP="xmonad"
       export XDG_CURRENT_DESKTOP="xmonad"
       DIR=$HOME/.guix-profile
       $DIR/bin/xinit -- $DIR/bin/Xorg :1 vt2 -keeptty \
                      -configdir $DIR/share/X11/xorg.conf.d \
                      -modulepath $DIR/lib/xorg/modules
   fi
else
    source "$HOME/.bashrc"
fi
