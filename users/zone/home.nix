{
  pkgs,
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
    "rofi".source = mkSymlink "${configPath}/rofi";
    "kitty".source = mkSymlink "${configPath}/kitty";
    "noctalia".source = mkSymlink "${configPath}/noctalia";
    "yazi".source = mkSymlink "${configPath}/yazi";
    "niri".source = mkSymlink "${configPath}/niri";
  };
  home.homeDirectory = "/home/zone";

  home.packages = with pkgs; [
    rofi
    xfce4-settings
    gthumb
    moonlight-qt
    remmina
    swayimg
    networkmanagerapplet
    wdisplays
    dconf-editor
    qtpass

    kitty
    qbittorrent-nox
    mpv
    ffmpeg
  ];
}
