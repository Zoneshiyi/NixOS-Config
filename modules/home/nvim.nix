{
  lib,
  config,
  pkgs,
  pkgs-24_11,
  userhome,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config/nvim";
  files = builtins.attrNames (builtins.readDir configPath);
in
{
  xdg.configFile = (
    builtins.listToAttrs (
      builtins.map (filename: {
        name = "nvim/${filename}";
        value = {
          source = mkSymlink "${configPath}/${filename}";
        };
      }) files
    )
  );
  home.packages = with pkgs; [
    lua5_1
    lua51Packages.luarocks
  ];
}
