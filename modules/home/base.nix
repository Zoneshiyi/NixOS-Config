{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    stateVersion = "24.11";
    homeDirectory =
      if (config.home.username == "root") then "/root" else "/home/${config.home.username}";
    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };
  home.packages = with pkgs; [
    age
    inputs.agenix.packages.${pkgs.system}.default

    # utils
    efibootmgr
    usb-modeswitch
    tcpdump
    usbutils
    inetutils
    parted
    psmisc
    unzip
    nurl
    file
    ripgrep
    fd
    procs
    fzf
    jq
    bc
    socat

    fastfetch
    bat
    zoxide
    tldr
    navi
    tmux
    # neovim
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    yazi
    btop
    git
    curl
    jqp
    git-repo
    starship
    aria2
    lux

  ];

  # targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
