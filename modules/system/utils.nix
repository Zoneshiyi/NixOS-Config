{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    parted
    efibootmgr
    usb-modeswitch
    tcpdump
    usbutils
  ];
}
