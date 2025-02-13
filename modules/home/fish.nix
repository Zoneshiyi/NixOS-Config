{
  lib,
  pkgs,
  config,
  userhome,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config/fish";
  funcFiles = builtins.attrNames (builtins.readDir "${configPath}/functions");
  templatesPath = "${userhome}/.config/templates";
in
{
  programs.atuin.enable = true;
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "main";
          hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "main";
          hash = "sha256-85iU1QzcZmZYGhK30/ZaKwJNLTsx+j3w6St8bFiQWxc=";
        };
      }
    ];
  };
  xdg.configFile =
    (builtins.listToAttrs (
      builtins.map (filename: {
        name = "fish/functions/${filename}";
        value = {
          source = mkSymlink "${configPath}/functions/${filename}";
        };
      }) funcFiles
    ))
    // {
      "fish/config.fish" = {
        source = lib.mkForce (mkSymlink "${configPath}/config.fish");
      };
      "fish/fish_variables" = {
        source = mkSymlink "${templatesPath}/fish/fish_variables";
      };
    };
}
