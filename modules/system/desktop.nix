{
  pkgs,
  inputs,
  ...
}:
let
  hyprpkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  # services.xserver.enable = true;
  services.displayManager = {
    defaultSession = "niri";
    gdm = {
      enable = true;
      banner = '''';
    };
  };
  programs = {
    xwayland.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = hyprpkgs.hyprland;
      portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
    };
    hyprlock = {
      enable = true;
    };
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
    qt5.qtbase
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
