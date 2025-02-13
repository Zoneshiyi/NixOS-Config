{
  userhome,
  config,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userhome}/NixOS/config";
in
{
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/dev.nix
    ../../modules/home/fish.nix
    ../../modules/home/nvim.nix
    ../../modules/home/tmux.nix
  ];
  xdg.configFile = {
    "git".source = mkSymlink "${configPath}/git";
  };
}
