{
  lib,
  pkgs,
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
    ./themes.nix
  ];
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
    desktop = null;
    publicShare = null;
    templates = null;
    documents = "${homeDir}/Documents";
    download = "${homeDir}/Downloads";
    music = "${homeDir}/Music";
    pictures = "${homeDir}/Pictures";
    videos = "${homeDir}/Videos";
    extraConfig = {
      CODES = "${homeDir}/Codes";
      TMP = "${homeDir}/Tmp";
    };
  };
  xresources.extraConfig = ''
    #include "${homeDir}/.config/templates/Xresources"
  '';
  services = {
    blueman-applet.enable = true;
  };
  home.activation = {
    create-templates = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${templatesPath}"
      shopt -s nullglob dotglob
      for item in "${configPath}/templates/"*; do
        target="${templatesPath}/$(basename "$item")"
        [ -e "$target" ] && continue
        if [ -d "$item" ]; then
          cp -r "$item" "$target"
        elif [ -f "$item" ]; then
          cp "$item" "$target"
        fi
      done
      shopt -u nullglob dotglob
    '';
  };
  home.packages = with pkgs; [
    xwayland-satellite

    brightnessctl
    noctalia
    xdg-launch
    xrdb

    trashy
  ];
}
