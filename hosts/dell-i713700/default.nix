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
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/e8f7a703-5e50-4d2b-b381-add1e91ecae0";
    fsType = "ext4";
  };

  # virtualisation.docker.daemon.settings = {
  #   data-root = "/data/docker";
  # };
  # virtualisation.docker.storageDriver = "overlay2";

  system.stateVersion = "24.11";

}
