{
  lib,
  pkgs,
  inputs,
  config,
  configPath,
  ...
}:
let
  homeDir = config.home.homeDirectory;
  templatesPath = "${homeDir}/.config/templates";
in
{
  imports = [
    ./alacritty.nix
    ./browser.nix
    ./dunst.nix
    ./themes.nix
  ];
  wayland.windowManager.hyprland.systemd.enable = false;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    publicShare = null;
    templates = null;
    documents = "${homeDir}/Documents";
    download = "${homeDir}/Downloads";
    music = "${homeDir}/Music";
    pictures = "${homeDir}/Pictures";
    videos = "${homeDir}/Videos";
    extraConfig = {
      XDG_CODES_DIR = "${homeDir}/Codes";
      XDG_TMP_DIR = "${homeDir}/Tmp";
    };
  };
  xresources.extraConfig = ''
    #include "${homeDir}/.config/templates/Xresources"
  '';
  services = {
    swww = {
      enable = true;
      package = inputs.swww.packages.${pkgs.system}.swww;
    };
  };
  home.activation = {
    create-templates = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "${templatesPath}" ]; then
        mkdir -p "${templatesPath}"
      fi
      mkdir -p "${templatesPath}/wallpapers"
      for item in "${configPath}/templates/"*; do
        if [ -e ${templatesPath}/$(basename $item) ]; then
          continue
        fi
        [ -d "$item" ] && cp -r "$item" "${templatesPath}/"
        [ -f "$item" ] && cp "$item" "${templatesPath}/"
      done
    '';
  };
  home.packages = with pkgs; [
    hypridle
    hyprsunset
    pyprland
    swaybg
    dunst
    brightnessctl
    wlogout
    eww
    xdg-launch
    xorg.xrdb

    grim
    slurp
    swappy

    trashy
  ];
}
