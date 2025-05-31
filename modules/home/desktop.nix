{
  pkgs,
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
    documents = "${homeDir}/Documents";
    download = "${homeDir}/Downloads";
    music = "${homeDir}/Music";
    pictures = "${homeDir}/Pictures";
    videos = "${homeDir}/Videos";
    extraConfig = {
      XDG_CODES_DIR = "${homeDir}/Codes";
      XDG_TMP_DIR = "${homeDir}/Tmp";
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
    eww
    xdg-launch

    grim
    slurp
    swappy

    trashy
  ];
}
