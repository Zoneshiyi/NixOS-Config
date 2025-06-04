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
    ./dunst.nix
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
  xresources.extraConfig = ''
    #include "${homeDir}/.config/templates/Xresources"
  '';
  services = {
    swww = {
      enable = true;
      package = inputs.swww.packages.${pkgs.system}.swww;
    };
  };
  home.packages = with pkgs; [
    hypridle
    hyprsunset
    pyprland
    swaybg
    dunst
    brightnessctl
    wlogout
    eww
    xdg-launch
    xorg.xrdb

    grim
    slurp
    swappy

    trashy
  ];
}
