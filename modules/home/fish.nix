{
  lib,
  pkgs,
  config,
  configPath,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  funcFiles = builtins.attrNames (builtins.readDir "${configPath}/fish/functions");
  templatesPath = "${config.home.homeDirectory}/.config/templates";
in
{
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
    ];
  };
  xdg.configFile =
    (builtins.listToAttrs (
      builtins.map (filename: {
        name = "fish/functions/${filename}";
        value = {
          source = mkSymlink "${configPath}/fish/functions/${filename}";
        };
      }) funcFiles
    ))
    // {
      "fish/config.fish" = {
        source = lib.mkForce (mkSymlink "${configPath}/fish/config.fish");
      };
      "fish/fish_variables" = {
        source = mkSymlink "${templatesPath}/fish/fish_variables";
      };
    };
}
