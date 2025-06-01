{
  pkgs,
  inputs,
  ...
}:
let
  hyprpkgs = inputs.hyprland.packages.${pkgs.system};
in
{
  # services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
    banner = '''';
  };
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      package = hyprpkgs.hyprland;
      portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
    };
    xwayland.enable = true;
    hyprlock = {
      enable = true;
    };
  };
  programs = {
    dconf.enable = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
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
      wlr.enable = true;
    };
    terminal-exec = {
      enable = true;
      settings = {
        Hyprland = [
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
    libsForQt5.qt5.qtbase
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtbase
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    wlr-randr
    wlrctl
    xdg-desktop-portal-wlr
    wl-clipboard

    wireshark
  ];
}
