{
  config,
  userhome,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config/eww";
in
{
  xdg.configFile = {
    "eww".source = mkSymlink "${configPath}";
  };
}
