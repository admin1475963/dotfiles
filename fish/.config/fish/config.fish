# guix
set -gx GUIX_PROFILE "$HOME/.guix-profile"
set fish_function_path $fish_function_path "$GUIX_PROFILE/share/fish/functions"
fenv source "$GUIX_PROFILE/etc/profile"

# Environment variables
set -gx PATH $HOME/.local/bin $PATH
set -gx EDITOR "emacsclient -c -a 'emacs'"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -gx LOCAL_APPS "$HOME/Applications"
set -gx WALLPAPERS "$HOME/Pictures/wallpapers"

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

set -gx QT_QPA_PLATFORMTHEME qt5ct

set -gx GNUPGHOME "$HOME/.gnupg"
set -gx CONDARC "$XDG_CONFIG_HOME/conda/condarc"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx GRADLE_HOME "$XDG_DATA_HOME/gradle"
set -gx XINITRC "$XDG_CONFIG_HOME/X11/xinitrc"

systemctl --user import-environment PATH
systemctl --user import-environment XDG_CONFIG_HOME

# Aliases
alias l "lsd -la $argv"
alias ls lsd
alias tlmgr "/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

# Aliases for user local apps
alias docker-credential-pass 'pass'
alias htim "$LOCAL_APPS/htop-vim/bin/htop"
alias conda-switch 'eval /home/admin1475963/Applications/anaconda3/bin/conda "shell.fish" "hook" $argv | source'

if status is-login && test -z $TMUX
   emacs --daemon &> /tmp/emacs.log &
   if test -z $DISPLAY
      if test $XDG_VTNR = 1
         sway --unsupported-gpu
      else if test $XDG_VTNR = 2
         startx "$XDG_CONFIG_HOME/X11/xinitrc" --
      end
   end
end

if status is-interactive
   starship init fish | source
end
