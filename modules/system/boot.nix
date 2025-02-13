{
  pkgs,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      grub = {
        enable = true;
        configurationLimit = 3;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        theme = "${pkgs.catppuccin}/grub";
        splashImage = null;
        gfxmodeEfi = "auto";
        gfxpayloadEfi = "keep";
        gfxmodeBios = "auto";
        gfxpayloadBios = "keep";
      };
      timeout = 3;
    };
    # plymouth = {
    #   enable = true;
    #   theme = "catppuccin-macchiato";
    #   themePackages = with pkgs; [
    #     catppuccin-plymouth
    #   ];
    # };
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
