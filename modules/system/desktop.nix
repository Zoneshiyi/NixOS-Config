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
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
    banner = '''';
  };
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
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
    appimage = {
      enable = true;
      binfmt = true;
    };
    dconf.enable = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      thunar-archive-plugin
      tumbler
    ];
  };
  xdg.icons.enable = true;
  xdg.mime = {
    enable = true;
    defaultApplications = { };
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
    xdg-terminal-exec
    # echo kitty.desktop >> $HOME/.config/xdg-terminals.list
  ];
}
