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
    "hypr".source = mkSymlink "${configPath}/hypr";
    "rofi".source = mkSymlink "${configPath}/rofi";
    "wlogout".source = mkSymlink "${configPath}/wlogout";
    "kitty".source = mkSymlink "${configPath}/kitty";
    "eww".source = mkSymlink "${configPath}/eww";
    "yazi".source = mkSymlink "${configPath}/yazi";
    "pypr".source = mkSymlink "${configPath}/pypr";
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
    copyq
    networkmanagerapplet
    waypaper
    awww
    wdisplays
    dconf-editor
    qtpass
    rclone
    vial

    kitty
    qbittorrent-nox
    vscode
    obsidian
    wpsoffice
    qq
    mpv
    ffmpeg
  ];

  programs.pi-coding-agent.enable = true;
}
