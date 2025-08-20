{
  imports = [
    ./modules/home/core.nix
    ./modules/home/dev.nix
    ./modules/home/nvim.nix
    ./modules/home/shell.nix
    ./modules/home/tmux.nix
  ];
  home.username = "zone";
  home.homeDirectory = "/home/zone/";
}
