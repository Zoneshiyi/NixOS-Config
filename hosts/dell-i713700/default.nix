{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "dell-i713700";
  nixpkgs.config.allowUnfree = true;

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C6B7-B828";
    fsType = "vfat";
  };

  system.stateVersion = "24.11";

}
