export GUIX_PROFILE="$HOME/.guix-profile"
source "$GUIX_PROFILE/etc/profile"

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="emacsclient -c -a 'emacs'"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export LOCAL_APPS="$HOME/Applications"
export WALLPAPERS="$HOME/Pictures/wallpapers"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_THEME="Arc-Dark"

export GNUPGHOME="$HOME/.gnupg"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GRADLE_HOME="$XDG_DATA_HOME/gradle"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

if [[ $(dirname $(tty)) == "/dev/pts" && $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi
