{
  pkgs,
  ...
}:
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

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    (hplip.override {
      # disable gui tray
      withQt5 = false;
    })
  ];

  services.sing-box = {
    enable = true;

    settings = {
      log = {
        level = "warn";
        timestamp = true;
      };

      inbounds = [
        {
          type = "socks";
          tag = "socks-in";
          listen = "10.12.190.184"; # 只绑这张网卡
          listen_port = 12345;
        }
      ];

      outbounds = [
        {
          type = "direct";
          tag = "direct";
        }
        {
          type = "block";
          tag = "block";
        }
      ];

      route = {
        rules = [
        { inbound = "socks-in"; source_ip_cidr = "10.12.180.6/32"; outbound = "direct"; }
        { inbound = "socks-in"; outbound = "block"; }
      ];
      };
    };
  };

  services.firewalld.zones.public.ports = [
    {
      port = 12345;
      protocol = "tcp";
    }
  ];
}
