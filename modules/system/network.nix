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
  users.users.zone.extraGroups = [
    "networkmanager"
  ];
  networking.networkmanager = {
    enable = true;
    ethernet.macAddress = "permanent";
    insertNameservers = [
      "119.29.29.29"
      "119.28.28.28"
    ];
    wifi.backend = "iwd";
  };
  networking = {
    wireless.dbusControlled = true;
    firewall.enable = false;
    nftables.enable = true;
  };
  environment.systemPackages = with pkgs; [
    (pkgs.firewalld-gui.overrideAttrs {
      withGui = true;
    })
  ];
  systemd.services.firewalld = {
    description = "Custom Firewall Daemon";
    wantedBy = [ "multi-user.target" ];
    requires = [ "dbus.service" ];
    after = [
      "dbus.service"
      "network.target"
    ];
    environment = {
      DBUS_SYSTEM_BUS_ADDRESS = "unix:path=/run/dbus/system_bus_socket";
    };
    serviceConfig = {
      Type = "dbus";
      BusName = "org.fedoraproject.FirewallD1";
      ExecStart = "${pkgs.firewalld-gui}/bin/firewalld --nofork --system-config /etc/firewalld";
      Restart = "no";
    };
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
  services.tailscale.enable = true;
}
