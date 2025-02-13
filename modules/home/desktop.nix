{
  pkgs,
  pkgs-24_11,
  ...
}:
{
  home.packages = with pkgs; [
    hyprsunset
    pyprland
    swww
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

    grim
    slurp
    swappy
  ];
}
