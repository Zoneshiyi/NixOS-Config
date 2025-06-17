{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ../../modules/system
  ];

  networking.hostName = "i512600kf-2070s";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  fileSystems."/mnt/samsung-T5" = {
    device = "/dev/disk/by-uuid/C5487018323948B6";
    fsType = "ntfs";
  };

  boot.kernelParams = [
    # "video=DP-2:e"
  ];

  boot.initrd.kernelModules = [
  ];
  boot.kernelModules = [
    # "8852bu"
  ];

  boot.extraModulePackages = [
    # pkgs.linuxKernel.packages.linux_zen.rtl8852bu
  ];
  services.udev.extraRules = ''
    ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 0bda -p 1a2b -V 0bda -P b851 -K"
  '';

  boot.loader.grub.gfxmodeEfi = lib.mkForce "2560x1440x32,1280x720x32";
  boot.loader.grub.gfxmodeBios = lib.mkForce "2560x1440x32,1280x720x32";

  hardware.nvidia-container-toolkit.enable = true;

  boot.loader.grub.extraEntries = ''
    menuentry "Windows 11" {
      search --fs-uuid --no-floppy --set=root 5ADD-520F
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';

  system.stateVersion = "24.11";
}
