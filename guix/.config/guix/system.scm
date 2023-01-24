(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu services nix)
             (gnu services desktop)
             (gnu services xorg)
             (gnu packages package-management)
             (gnu packages certs)
             (gnu packages emacs)
             (gnu packages wm)
             (gnu packages vim))

(operating-system
 (kernel linux)

 (kernel-arguments
  (append
   (list
    "nouveau.modeset=0"
    "modprobe.blacklist=pcspkr")
   %default-kernel-arguments))

 (initrd microcode-initrd)

 (firmware (list linux-firmware))

 (host-name "ADMIN1475963")

 (timezone "Asia/Tashkent")

 (locale "en_US.utf8")

 (keyboard-layout (keyboard-layout "us"))

 (users
  (cons*
   (user-account
    (name "admin1475963")
    (comment "Mukhammad Ilkhomov")
    (group "users")
    (home-directory "/home/admin1475963")
    (supplementary-groups '("wheel" "netdev" "video" "audio" "uinput" "input")))
   %base-user-accounts))

 (groups
  (cons*
   (user-group (name "uinput"))
   %base-groups))

 (packages
  (append
   (list
    nss-certs
    emacs
    vim
    sway
    swaylock
    swayidle
    i3lock-color
    i3-gaps)
   %base-packages))

 (services
  (append
   (list
    (service nix-service-type)
    (screen-locker-service swaylock "swaylock")
    (screen-locker-service i3lock-color "i3lock"))
   (modify-services
    %desktop-services
    (guix-service-type
     config => (guix-configuration
                (inherit config)
                (substitute-urls
                 (append (list "https://substitutes.nonguix.org") %default-substitute-urls))
                (authorized-keys
                 (append (list (plain-file
                                "non-guix.pub"
                                "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                         %default-authorized-guix-keys))))
    (delete gdm-service-type)
    (delete screen-locker-service-type)
    (delete gdm-file-system-service))))

 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets (list "/boot/efi"))
   (keyboard-layout keyboard-layout)))

 (mapped-devices
  (list
   (mapped-device
    (source "/dev/vgssd")
    (targets (list "vgssd-root"))
    (type lvm-device-mapping))
   (mapped-device
    (source "/dev/vghdd")
    (targets (list "vghdd-home"))
    (type lvm-device-mapping))
   (mapped-device
    (source (uuid "8688f681-6288-4f5e-b31e-f7b6f8a9051f"))
    (targets (list "root"))
    (type luks-device-mapping))
   (mapped-device
    (source (uuid "645bef0f-077d-42d7-9626-cb41d7ee9767"))
    (targets (list "home"))
    (type luks-device-mapping))))

 (file-systems
  (append
   (list (file-system
          (device (file-system-label "ROOT"))
          (mount-point "/")
          (type "ext4")
          (dependencies mapped-devices))
         (file-system
          (device (file-system-label "BOOT"))
          (mount-point "/boot")
          (type "ext4"))
         (file-system
          (device (file-system-label "EFI"))
          (mount-point "/boot/efi")
          (type "vfat"))
         (file-system
          (device (file-system-label "HOME"))
          (mount-point "/home")
          (type "ext4")
          (dependencies mapped-devices)))
   %base-file-systems)))
