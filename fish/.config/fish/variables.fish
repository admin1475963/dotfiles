set -Ux GUIX_PROFILE "$HOME/.guix-profile"
set -U fish_function_path $fish_function_path "$GUIX_PROFILE/share/fish/functions"

set -Ux PATH $HOME/.local/bin $PATH
set -Ux EDITOR "emacsclient -c -a 'emacs'"
set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -Ux LOCAL_APPS "$HOME/Applications"
set -Ux WALLPAPERS "$HOME/Pictures/wallpapers"

set -Ux XDG_CURRENT_DESKTOP "sway"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_STATE_HOME "$HOME/.local/state"

set -Ux QT_QPA_PLATFORM "wayland"
set -Ux QT_QPA_PLATFORMTHEME "qt5ct"

set -Ux GNUPGHOME "$HOME/.gnupg"
set -Ux CONDARC "$XDG_CONFIG_HOME/conda/condarc"
set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -Ux CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -Ux GRADLE_HOME "$XDG_DATA_HOME/gradle"
set -Ux XINITRC "$XDG_CONFIG_HOME/X11/xinitrc"