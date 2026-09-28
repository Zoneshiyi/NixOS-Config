{
  pkgs,
  config,
  lib,
  ...
}:
let
  greeter = config.services.displayManager.noctalia-greeter;
in
{
  # services.xserver.enable = true;
  services.displayManager = {
    defaultSession = "niri";

    noctalia-greeter = {
      enable = true;
      passwordlessSyncUsers = [ "zone" ];
      cursorTheme = {
        package = pkgs.whitesur-cursors;
        name = "WhiteSur-cursors";
      };
      settings = {
        session.default = "Niri";
        cursor.size = 32;
        keyboard = {
          layout = "us";
          numlock = true;
        };
        appearance = {
          theme_mode = "dark";
          hide_logo = true;
        };
      };
    };
  };

  services.greetd.settings.default_session.command =
    "${lib.getExe' pkgs.coreutils "env"} "
    + "XDG_DATA_DIRS=${config.services.displayManager.sessionData.desktops}/share "
    + "${lib.getExe' greeter.package "noctalia-greeter-session"} ${lib.escapeShellArgs greeter.extraArgs}";
  programs = {
    niri.enable = true;
    dconf.enable = true;
    thunar.enable = true;
    thunar.plugins = with pkgs; [
      xfce4-exo
      thunar-archive-plugin
      tumbler
    ];
    wireshark = {
      enable = true;
      dumpcap.enable = true;
    };
  };
  xdg = {
    icons.enable = true;
    menus.enable = true;
    autostart.enable = true;
    mime = {
      enable = true;
      defaultApplications = { };
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      config.common.default = [
        "gnome"
        "gtk"
      ];
    };
    terminal-exec = {
      enable = true;
      settings = {
        niri = [
          "Alacritty.desktop"
        ];
      };
    };
  };
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    settings.port = 47989;
  };
  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };
  environment.systemPackages = with pkgs; [
    qt5.qtbase
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtbase
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    wlr-randr
    wlrctl
    wl-clipboard

    wireshark
  ];
}
