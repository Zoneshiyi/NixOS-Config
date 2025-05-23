{
  pkgs,
  pkgs-24_11,
  inputs,
  config,
  ...
}:
let
  homeDir = config.home.homeDirectory;
in
{
  imports = [
    ./alacritty.nix
    ./browser.nix
    ./themes.nix
  ];
  wayland.windowManager.hyprland.systemd.enable = false;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    publicShare = null;
    templates = null;
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    videos = "${config.home.homeDirectory}/Videos";
    extraConfig = {
      XDG_CODES_DIR = "${config.home.homeDirectory}/Codes";
      XDG_TMP_DIR = "${config.home.homeDirectory}/Tmp";
    };
  };
  home.packages = with pkgs; [
    hyprsunset
    pyprland
    inputs.swww.packages.${pkgs.system}.swww
    swaybg
    dunst
    brightnessctl
    wlogout
    waybar
    eww

    grim
    slurp
    swappy

    trashy
  ];
}
