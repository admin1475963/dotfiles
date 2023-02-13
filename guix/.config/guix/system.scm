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

(define md-root
  (list
   (mapped-device
    (source (uuid "e6fa797e-1dd5-4673-a60c-5fcf0ad2ea04"))
    (targets (list "luks-ssd"))
    (type luks-device-mapping))
   (mapped-device
    (source "/dev/vg-ssd")
    (targets (list "vg--ssd-root"))
    (type lvm-device-mapping))))

(define md-home
  (list
   (mapped-device
    (source (uuid "156bd6a3-2103-4772-8d72-c4954debe004"))
    (targets (list "luks-hdd"))
    (type luks-device-mapping))
   (mapped-device
    (source "/dev/vg-hdd")
    (targets (list "vg--hdd-home"))
    (type lvm-device-mapping))
   ))

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

 (mapped-devices (append md-root md-home))

 (file-systems
  (append
   (list (file-system
          (device (file-system-label "ROOT"))
          (mount-point "/")
          (type "ext4")
          (dependencies md-root))
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
      (dependencies md-home)))
   %base-file-systems)))
