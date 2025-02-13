{
  pkgs,
  config,
  userhome,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config/tmux";
in
{
  xdg.configFile = {
    "tmux/tmux.conf".source = mkSymlink "${configPath}/tmux.conf";
    "templates/tmux/plugins/catppuccin" = {
      source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "tmux";
        rev = "main";
        hash = "sha256-FkpHkXAeEHKHZSaDXuGskbkbMkKt/jKOf6lJSaqoE8g=";
      };
    };
  };
}
