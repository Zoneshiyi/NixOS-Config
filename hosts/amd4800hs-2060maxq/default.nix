{
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "amd4800hs-2060maxq";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C5D2-9AC0";
    fsType = "vfat";
  };

  #disable nouveau
  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];
  services.libinput.enable = true;
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

  environment.systemPackages = with pkgs; [
    vdpauinfo
    libva-utils
  ];

  hardware.nvidia = {
    videoAcceleration = true;
    modesetting.enable = true;

    # All PRIME configurations require setting the PCI bus IDs of the two GPUs.
    prime = {
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
      # PRIME Sync and Offload Mode cannot be enabled at the same time.
      sync.enable = true;
      # reverseSync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
    };

    forceFullCompositionPipeline = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  system.stateVersion = "24.11";

}
