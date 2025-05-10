{
  pkgs,
  pkgs-24_11,
  config,
  userhome,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config";
in
{

  imports = [
    ../../modules/home/default.nix
  ];
  xdg.configFile = {
    "hypr".source = mkSymlink "${configPath}/hypr";
    "waybar".source = mkSymlink "${configPath}/waybar";
    "rofi".source = mkSymlink "${configPath}/rofi";
    "wlogout".source = mkSymlink "${configPath}/wlogout";
    "kitty".source = mkSymlink "${configPath}/kitty";
    "git".source = mkSymlink "${configPath}/git";
  };

  programs.firefox.enable = true;
  home.packages = with pkgs; [
    networkmanagerapplet
    waypaper
    wdisplays
    dconf-editor
    qtpass

    kitty
    alacritty
    qbittorrent
    # netease-cloud-music-gtk
    pkgs-24_11.yesplaymusic
    vscode
    obsidian
    google-chrome
    qq
    wechat-uos
    mpv
    ffmpeg
  ];
}
