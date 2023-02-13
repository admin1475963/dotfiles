(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "rust"
                                            "vlc"
                                            "mpv"
                                            "texlive"
                                            "telegram-desktop"
                                            "icedove"
                                            "arc-theme"
                                            "okular"
                                            "qtbase"
                                            "emacs-guix"
                                            "picom"
                                            "emacs-magit"
                                            "pass-otp"
                                            "qtwayland"
                                            "flatpak"
                                            "emacs-auctex"
                                            "emacs-org-roam-ui"
                                            "emacs-org-roam"
                                            "obs"
                                            "emacs"
                                            "i3status"
                                            "zoom"
                                            "openssh"
                                            "dunst"
                                            "feh"
                                            "imv"
                                            "xf86-video-nouveau"
                                            "xorg-server"
                                            "lldb"
                                            "clang-toolchain"
                                            "pinentry"
                                            "qbittorrent"
                                            "breeze"
                                            "ungoogled-chromium"
                                            "xorg-server-xwayland"
                                            "pamixer"
                                            "xournalpp"
                                            "inkscape"
                                            "password-store"
                                            "gimp"
                                            "qt5ct"
                                            "git"
                                            "libreoffice"
                                            "qutebrowser"
                                            "bemenu"
                                            "grim"
                                            "alacritty"
                                            "emacs-doom-modeline"
                                            "cmake"
                                            "xinit"
                                            "breeze-icons"
                                            "slurp"
                                            "p7zip"
                                            "emacs-eglot"
                                            "gdb"
                                            "guile"
                                            "gnupg"
                                            "fish"
                                            "unzip"
                                            "egl-wayland"
                                            "syncthing"
                                            "bat"
                                            "exa"
                                            "xf86-input-libinput"
                                            "emacs-doom-themes"
                                            "emacs-haskell-mode"
                                            "emacs-key-chord"
                                            "emacs-which-key"
                                            "emacs-auto-complete"
                                            "emacs-general"
                                            "emacs-use-package"
                                            "emacs-ivy"
                                            "emacs-dracula-theme"
                                            "emacs-evil-collection"
                                            "emacs-evil"
                                            "vim"
                                            "dmenu"
                                            "ncurses"
                                            "xstow"
                                            "xf86-video-fbdev"
                                            "fish-foreign-env"
                                            "arc-icon-theme"
                                            "gcc-toolchain"
                                            "font-dejavu"
                                            "font-liberation"
                                            "ghc"
                                            "python"
                                            "font-openmoji"
                                            "ydotool"
                                            "fontconfig"
                                            "kmonad"
                                            "wev"
                                            "brightnessctl"
                                            "htop"
                                            "alsa-utils"
                                            "font-awesome"
                                            "font-google-noto"
                                            "font-hack"
                                            "make"
                                            "llvm"
                                            "gcc"
                                            "vifm"
                                            "neovim"
                                            "stow"
                                            "tmux")))
