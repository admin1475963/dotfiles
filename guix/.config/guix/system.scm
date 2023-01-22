(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu services)
             (gnu services shepherd)
             (gnu services base)
             (gnu services dbus)
             (gnu services avahi)
             (gnu services networking)
             (gnu services sound)
             (gnu services nix)
             (gnu services desktop)
             (gnu system file-systems)
             (gnu system)
             (gnu system setuid)
             (gnu system shadow)
             (gnu system uuid)
             (gnu system pam)
             (gnu packages glib)
             (gnu packages admin)
             (gnu packages cups)
             (gnu packages freedesktop)
             (gnu packages avahi)
             (gnu packages xdisorg)
             (gnu packages scanner)
             (gnu packages suckless)
             (gnu packages linux)
             (gnu packages libusb)
             (gnu packages nfs)
             (gnu packages enlightenment)
             (gnu packages package-management)
             (guix records)
             (guix packages)
             (guix store)
             (guix ui)
             (guix utils)
             (guix gexp)
             (srfi srfi-1)
             (ice-9 format)
             (ice-9 match))


(operating-system
 (kernel linux)
 (kernel-arguments (list "nouveau.modeset=0"))
 (initrd microcode-initrd)
 (firmware (list linux-firmware))

 (host-name "ADMIN1475963")
 (timezone "Asia/Tashkent")
 (locale "en_US.utf8")

 (keyboard-layout (keyboard-layout "us"))

 (users (cons* (user-account
        (name "admin1475963")
        (comment "Mukhammad Ilkhomov")
        (group "users")
        (home-directory "/home/admin1475963")
        (supplementary-groups '("wheel" "netdev" "video" "audio")))
           %base-user-accounts))

 (packages
  (append
   (list (specification->package "emacs")
         (specification->package "vim")
         (specification->package "nss-certs")
         nix)
   %base-packages))

 (services (append
            (list
             ;; Add udev rules for MTP devices so that non-root users can access
             ;; them.
             (simple-service 'mtp udev-service-type (list libmtp))
             ;; Add polkit rules, so that non-root users in the wheel group can
             ;; perform administrative tasks (similar to "sudo").
             polkit-wheel-service

             ;; Allow desktop users to also mount NTFS and NFS file systems
             ;; without root.
             (simple-service 'mount-setuid-helpers setuid-program-service-type
                             (map (lambda (program)
                                    (setuid-program
                                     (program program)))
                                  (list (file-append nfs-utils "/sbin/mount.nfs")
                                        (file-append ntfs-3g "/sbin/mount.ntfs-3g"))))

             ;; The global fontconfig cache directory can sometimes contain
             ;; stale entries, possibly referencing fonts that have been GC'd,
             ;; so mount it read-only.
             fontconfig-file-system-service

             ;; NetworkManager and its applet.
             (service network-manager-service-type)
             (service wpa-supplicant-service-type)    ;needed by NetworkManager
             (service modem-manager-service-type)
             (service usb-modeswitch-service-type)

             ;; The D-Bus clique.
             (service avahi-service-type)
             (udisks-service)
             (service upower-service-type)
             (accountsservice-service)
             (service cups-pk-helper-service-type)
             (service colord-service-type)
             (geoclue-service)
             (service polkit-service-type)
             (elogind-service)
             (dbus-service)

             (service ntp-service-type)

             (service pulseaudio-service-type)
             (service alsa-service-type)
             (service nix-service-type))

            (modify-services
             %base-services
             (guix-service-type config => (guix-configuration
                                           (inherit config)
                                           (substitute-urls
                                            (append (list "https://substitutes.nonguix.org") %default-substitute-urls))
                                           (authorized-keys
                                            (append (list (local-file "./signing-key.pub")) %default-authorized-guix-keys)))))))

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

 (file-systems (append
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
                %base-file-systems))

 (swap-devices
  (list (swap-space
         (target "/swapfile")
         (dependencies file-systems)))))
