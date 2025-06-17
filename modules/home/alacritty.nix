{
  pkgs,
  pkgs-self,
  configPath,
  mkSymlink,
  ...
}:
{
  xdg.configFile = {
    "alacritty/alacritty.toml".source = mkSymlink "${configPath}/alacritty/alacritty.toml";
    "alacritty/themes" = {
      source = pkgs.fetchFromGitHub {
        owner = "alacritty";
        repo = "alacritty-theme";
        rev = "59a96ef4c734f97a1aadaa619b31cc1ca90a0fbc";
        hash = "sha256-1LRR4ciM/f1Fu9sLcq53b6eXK1qggvvkSY8iqF0Yw50=";
      };
    };
  };
  home.packages = [
    pkgs-self.alacritty-with-sixel
  ];
}
