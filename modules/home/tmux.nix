{
  pkgs,
  config,
  configPath,
  mkSymlink,
  ...
}:
{
  xdg.configFile = {
    "tmux/tmux.conf".source = mkSymlink "${configPath}/tmux/tmux.conf";
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
