{
  config,
  configPath,
  mkSymlink,
  ...
}:
{
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/dev.nix
    ../../modules/home/shell.nix
    ../../modules/home/nvim.nix
    ../../modules/home/tmux.nix
  ];
  xdg.configFile = {
    "git".source = mkSymlink "${configPath}/git";
    "starship.toml".source = mkSymlink "${configPath}/starship/starship.toml";
  };
}
