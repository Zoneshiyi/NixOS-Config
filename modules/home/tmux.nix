{
  pkgs,
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
        rev = "14a546fb64dc1141e5d02bac2185d8c1fd530d6a";
        hash = "sha256-poG3QCow2j6h/G7BLEA8v3ZJXuk28iPmH1J4t7vT55k=";
      };
    };
  };
  home.packages = with pkgs; [
    tmux
  ];
}
