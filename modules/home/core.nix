{
  pkgs,
  mkSymlink,
  configPath,
  ...
}:
{
  home = {
    stateVersion = "26.05";
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
    yazi
    btop
    git
    curl
    wget
    starship
  ];

  # targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
}
