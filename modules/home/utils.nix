{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    tcpdump
    parted
    nurl
    fastfetch
  ];
}
