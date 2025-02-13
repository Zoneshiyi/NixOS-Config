{
  pkgs,
  config,
  userhome,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config/alacritty";
in
{
  xdg.configFile = {
    "alacritty/alacritty.toml".source = mkSymlink "${configPath}/alacritty.toml";
    "alacritty/themes" = {
      source = pkgs.fetchFromGitHub {
        owner = "alacritty";
        repo = "alacritty-theme";
        rev = "master";
        hash = "sha256-mxmli6ZSm+90Jrwm9fju0sAstNZgBEx4hSaWigs6rWc=";
      };
    };
  };
}
