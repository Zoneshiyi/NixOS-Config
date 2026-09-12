{
  pkgs,
  ...
}:
{
  services.openssh = {
    enable = true;
    # ~/.ssh/authorized_keys
    authorizedKeysInHomedir = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
      PubkeyAuthentication = true;
    };
  };
  # services.qbittorrent = {
  #   webuiPort = 9615;
  #   enable = true;
  #   serverConfig = {
  #     Preferences = {
  #       WebUI = {
  #         Username = "Zone";
  #         Password_PBKDF2 = "tqtRQxPVQYPhLbsnwK911A==:nvdwMR/Xxxgsvl5OckRKSaYX8B+X1dwiZymDTNNlVMusgv6a4lq/Du03ZOtZixotVpdq6HMZZ/LyHG5iHYjGNg==";
  #       };
  #     };
  #   };
  # };
  users.users.zone.extraGroups = [
    "networkmanager"
  ];
  networking.networkmanager = {
    enable = true;
    ethernet.macAddress = "permanent";
    # insertNameservers = [
    #   "119.29.29.29"
    #   "119.28.28.28"
    # ];
    wifi.backend = "iwd";
  };

  services.firewalld = {
    enable = true;
    package = pkgs.firewalld-gui;
    settings = {
      DefaultZone = "public";
    };
    zones = {
      public.services = [ "ssh" ];
    };
  };

  networking = {
    wireless.dbusControlled = true;
    firewall.enable = false;
    nftables.enable = true;
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.fedoraproject.FirewallD1.") == 0 && subject.isInGroup("networkmanager")) {
        return polkit.Result.YES;
      }
    });
  '';

  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
    proxies = {
      clash = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 7897;
      };
    };
  };
  # services.tailscale.enable = true;
}
