{
  pkgs,
  inputs,
  ...
}:
{
  time.timeZone = "Asia/Shanghai";

  environment.variables = {
  };
  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  users.users.zone = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "input"
    ];
  };
  users.defaultUserShell = pkgs.fish;

  services.gvfs = {
    enable = true;
    package = pkgs.gvfs;
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  programs = {
    fish.enable = true;
    nix-ld.enable = true;
    clash-verge.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];
}
