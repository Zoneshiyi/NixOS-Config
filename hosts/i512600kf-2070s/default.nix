{
  config,
  lib,
  pkgs,
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

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C5D2-9AC0";
    fsType = "vfat";
  };

  boot.kernelParams = [
    # "video=DP-2:e"
  ];

  boot.initrd.kernelModules = [
  ];
  boot.kernelModules = [
    "8851bu"
  ];

  boot.extraModulePackages = [
    (config.boot.kernelPackages.callPackage ../../derivations/rtl8851bu.nix { })
  ];

  boot.loader.grub.gfxmodeEfi = lib.mkForce "2560x1440x32,1280x720x32";
  boot.loader.grub.gfxmodeBios = lib.mkForce "2560x1440x32,1280x720x32";

  hardware.nvidia-container-toolkit.enable = true;

  system.stateVersion = "24.11";
}
