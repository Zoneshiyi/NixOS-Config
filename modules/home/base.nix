{
  inputs,
  pkgs,
  lib,
  userhome,
  config,
  ...
}:
{
  home = {
    stateVersion = "24.11";
    homeDirectory = lib.mkDefault "${userhome}";
    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };
  home.packages = with pkgs; [
    age
    inputs.agenix.packages.${pkgs.system}.default
    psmisc
    fastfetch

    gcc
    gnumake
    (pkgs.python312.withPackages (
      ps: with ps; [
        pynvim
      ]
    ))

    inetutils
    nurl
    bat
    zoxide
    file
    tldr
    navi
    tmux
    # neovim
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    ripgrep
    yazi
    procs
    btop
    bottom
    git
    curl
    fd
    fzf

    aria2
    lux
  ];

  # targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
