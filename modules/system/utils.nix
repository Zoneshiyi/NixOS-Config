{
  pkgs,
  ...
}:
{
  programs.wireshark.enable = true;
  programs.wireshark.dumpcap.enable = true;
  environment.systemPackages = with pkgs; [
    wireshark
    parted
    efibootmgr
    usb-modeswitch
    tcpdump
    usbutils
    bc
    git-repo
    inetutils
  ];
}
