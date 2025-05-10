{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];
  boot.supportedFilesystems = [ "ntfs" ];

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

  boot.loader.grub.extraEntries = ''
    menuentry "Windows 11" {
      search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
      chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';
  virtualisation.docker.enableNvidia = false;

  system.stateVersion = "24.11";

}
