{
  config,
  userhome,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config/starship";
in
{
  xdg.configFile = {
    "starship.toml".source = mkSymlink "${configPath}/starship.toml";
  };
}
