{
  ...
}:
{
  imports = [
    ../../modules/home/core.nix
    ../../modules/home/dev.nix
    ../../modules/home/shell.nix
    ../../modules/home/nvim.nix
    ../../modules/home/tmux.nix
    ../../modules/home/utils.nix
  ];
  home.homeDirectory = "/root";
}
