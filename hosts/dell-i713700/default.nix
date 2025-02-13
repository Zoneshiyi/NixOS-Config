{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "dell-i713700";
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";

}
