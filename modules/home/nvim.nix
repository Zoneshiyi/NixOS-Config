{
  lib,
  config,
  pkgs,
  configPath,
  mkSymlink,
  ...
}:
let
  files = builtins.attrNames (builtins.readDir "${configPath}/nvim");
in
{
  xdg.configFile = (
    builtins.listToAttrs (
      builtins.map (filename: {
        name = "nvim/${filename}";
        value = {
          source = mkSymlink "${configPath}/nvim/${filename}";
        };
      }) files
    )
  );
  home.packages = with pkgs; [
    lua5_1
    lua51Packages.luarocks
  ];
}
