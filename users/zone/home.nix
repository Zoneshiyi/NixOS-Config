{
  pkgs,
  pkgs-24_11,
  pkgs-self,
  mkSymlink,
  configPath,
  ...
}:
{

  imports = [
    ../../modules/home/default.nix
    # Uncomment the following line to decrypt secrets
    # ./secrets.nix
  ];
  xdg.configFile = {
    "hypr".source = mkSymlink "${configPath}/hypr";
    "rofi".source = mkSymlink "${configPath}/rofi";
    "wlogout".source = mkSymlink "${configPath}/wlogout";
    "kitty".source = mkSymlink "${configPath}/kitty";
    "eww".source = mkSymlink "${configPath}/eww";
    "yazi".source = mkSymlink "${configPath}/yazi";
  };
  home.homeDirectory = "/home/zone";

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
    vial

    kitty
    qbittorrent
    # netease-cloud-music-gtk
    pkgs-24_11.yesplaymusic
    vscode
    obsidian
    wpsoffice
    qq
    pkgs-self.wechat
    mpv
    ffmpeg
  ];
}
