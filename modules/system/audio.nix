{
  pkgs,
  ...
}:
{
  xdg.sounds.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    # Whether to use PipeWire as the primary sound server
    audio.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    # systemWide = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    playerctl
  ];

  users.users.zone.extraGroups = [ "audio" ];
}
