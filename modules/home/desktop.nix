{
  pkgs,
  pkgs-24_11,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    hyprsunset
    pyprland
    # swww
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

    grim
    slurp
    swappy
  ];
}
