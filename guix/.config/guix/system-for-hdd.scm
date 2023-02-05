(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu services base)
             (gnu services desktop)
             (gnu services nix)
             (gnu services xorg)
             (gnu packages package-management)
             (gnu packages certs)
             (gnu packages emacs)
             (gnu packages wm)
             (gnu packages vim))

(define md
  (list
   (mapped-device
    (source (uuid "8688f681-6288-4f5e-b31e-f7b6f8a9051f"))
    (targets (list "hdd-luks"))
    (type luks-device-mapping))
   (mapped-device
    (source "/dev/mapper/root")
    (targets (list "root"))
    (type lvm-device-mapping))))

(define %udev-uinput-service
  (udev-rules-service
   'udev-uinput
   (udev-rule
    "uinput.rules"
    "KERNEL==\"uinput\", MODE=\"0660\", GROUP=\"uinput\", OPTIONS+=\"static_node=uinput\"")))

(operating-system
 (kernel linux)

 (kernel-arguments
  (append
   (list
    "nouveau.modeset=0"
    "modprobe.blacklist=pcspkr"
    "modprobe=uinput")
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
    (screen-locker-service i3lock-color "i3lock")
    %udev-uinput-service)
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

 (mapped-devices md)

 (file-systems
  (append
   (list (file-system
          (device (file-system-label "ROOT"))
          (mount-point "/")
          (type "ext4")
          (dependencies md))
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
          (dependencies md)))
   %base-file-systems)))
