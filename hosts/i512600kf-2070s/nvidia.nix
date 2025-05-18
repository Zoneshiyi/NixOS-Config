{
  pkgs,
  config,
  ...
}:
{
  hardware.nvidia-container-toolkit.enable = true;
  #disable nouveau
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  environment.variables = {
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };
  environment.sessionVariables = { };
  environment.systemPackages = with pkgs; [
    vdpauinfo
    libva-utils
  ];

  hardware.nvidia = {
    videoAcceleration = true;

    # If set true, maybe can solve Screen Tearing Issues(may produce issues in WebGL)
    forceFullCompositionPipeline = true;

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # NVidia open source kernel module
    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
