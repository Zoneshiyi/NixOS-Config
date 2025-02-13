{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    hyprls
    ntfs3g
    trashy
    psmisc

    parted
    efibootmgr
    usb-modeswitch
    tcpdump
    usbutils
    fastfetch
  ];
}
