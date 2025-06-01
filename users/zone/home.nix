{
  pkgs,
  pkgs-24_11,
  config,
  pkgs-self,
  mkSymlink,
  configPath,
  ...
}:
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
    "yazi".source = mkSymlink "${configPath}/yazi";
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
    vial

    kitty
    alacritty
    qbittorrent
    # netease-cloud-music-gtk
    pkgs-24_11.yesplaymusic
    vscode
    obsidian
    qq
    (pkgs-self.wechat)
    mpv
    ffmpeg
  ];
}
