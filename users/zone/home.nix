{
  pkgs,
  pkgs-24_11,
  config,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.home.homeDirectory}/NixOS/config";
in
{

  imports = [
    ../../modules/home/default.nix
  ];
  xdg.configFile = {
    "hypr".source = mkSymlink "${configPath}/hypr";
    "rofi".source = mkSymlink "${configPath}/rofi";
    "wlogout".source = mkSymlink "${configPath}/wlogout";
    "kitty".source = mkSymlink "${configPath}/kitty";
    "git".source = mkSymlink "${configPath}/git";
    "eww".source = mkSymlink "${configPath}/eww";
    "starship.toml".source = mkSymlink "${configPath}/starship/starship.toml";
  };

  home.packages = with pkgs; [
    rofi-wayland
    xfce.xfce4-settings
    gthumb
    moonlight-qt
    remmina
    swayimg
    copyq
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
    qq
    wechat-uos
    mpv
    ffmpeg
  ];
}
