{
  pkgs,
  pkgs-24_11,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland.systemd.enable = false;
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

    grim
    slurp
    swappy

    trashy
  ];
}
