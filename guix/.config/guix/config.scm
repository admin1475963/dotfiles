;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "bare bones" setup, with no X11 display server.

(use-modules (gnu bootloader grub-efi-bootloader)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(define md-ssd
  (mapped-device
   (source "vgssd")
   (target "vgssd-root")
   (type lvm-device-mapping))

(define md-hdd
  (mapped-device
   (source "vghdd")
   (target "vghdd-home")
   (type lvm-device-mapping)))

(define fs-root
  (file-system
   (device "/dev/mapper/vgssd-root")
   (mount-point "/")
   (type "ext4")
   (needed-for-boot #t)
   (dependencies (list md-ssd))))

(define fs-boot
  (file-system
   (device (file-system-label "boot"))
   (mount-point "/boot")
   (type "ext4")
   (needed-for-boot #t)
   (dependencies (list fs-root))))

(define fs-efi
  (file-system
   (device (file-system-label "efi"))
   (mount-point "/boot/efi")
   (type "vfat")
   (dependencies (list fs-boot))))

(define fs-home
  (file-system
   (device "/dev/mapper/vghdd-home")
   (mount-point "/")
   (type "ext4")
   (dependencies (list fs-root md-hdd))))

(operating-system
  (kernel linux)

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))))

  (initrd microcode-initrd)

  (firmware (list linux-firmware))

  (host-name "ADMIN1475963")

  (mapped-devices (list md-ssd md-hdd))

  (file-systems (append
                 (list fs-root fs-boot fs-efi fs-home)
                 %base-file-systems))
  (swap-space (target "/home/swap") (dependencies (list fs-home)))

  (users (cons
          (user-account
           (name "admin1475963")
           (group "admin1475963")
           (supplementary-groups '("wheel" "audio" "video"))
           (comment "Owner"))
          %base-user-accounts))

  (groups (cons
           (user-group (name "admin1475963"))
           %bas-groups))

  (timezone "Asia/Tashkent")

  (locale "en_US.utf8")

  (packages %base-packages)

  (services %base-services))
