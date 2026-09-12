{
  pkgs,
  mkSymlink,
  configPath,
  ...
}:
{
  home = {
    stateVersion = "26.05";
    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
  };
  xdg.configFile = {
    "git".source = mkSymlink "${configPath}/git";
    "starship.toml".source = mkSymlink "${configPath}/starship/starship.toml";
  };
  home.packages = with pkgs; [
    dash
    usbutils
    inetutils
    psmisc
    unzip
    file
    ripgrep
    fd
    procs
    fzf
    jq
    bc
    tree
    bat
    zoxide
    tldr
    navi
    yazi
    btop
    git
    curl
    wget
    jqp
    starship
  ];

  # targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
