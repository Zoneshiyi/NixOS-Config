{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    efibootmgr
    usb-modeswitch
    tcpdump
    parted
    nurl
    socat
    fastfetch
    git-repo
    aria2
    lux
  ];
}
