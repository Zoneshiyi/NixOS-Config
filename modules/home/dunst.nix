{
  configPath,
  mkSymlink,
  ...
}:
{
  services.dunst = {
    enable = true;
  };
  xdg.configFile."dunst/dunstrc".source = mkSymlink "${configPath}/dunst/dunstrc";
  xdg.configFile."dunst/script.sh".source = mkSymlink "${configPath}/dunst/script.sh";
}
