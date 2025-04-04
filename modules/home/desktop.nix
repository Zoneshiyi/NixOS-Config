{
  pkgs,
  pkgs-24_11,
  inputs,
  userhome,
  ...
}:
{
  wayland.windowManager.hyprland.systemd.enable = false;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    publicShare = null;
    templates = null;
    documents = "${userhome}/Documents";
    download = "${userhome}/Downloads";
    music = "${userhome}/Music";
    pictures = "${userhome}/Pictures";
    videos = "${userhome}/Videos";
    extraConfig = {
      XDG_CODES_DIR = "${userhome}/Codes";
      XDG_TMP_DIR = "${userhome}/Tmp";
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
    rofi-wayland
    copyq
    xfce.xfce4-settings
    swayimg
    gthumb
    moonlight-qt
    remmina

    grim
    slurp
    swappy

    trashy
  ];
}
