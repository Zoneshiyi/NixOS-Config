{
  pkgs,
  pkgs-24_11,
  inputs,
  ...
}:
{
  programs = {
    ssh.startAgent = true;
  };
  security.polkit = {
    enable = true;
    package = pkgs.polkit;
  };
  security.soteria = {
    enable = true;
    package = pkgs-24_11.soteria;
  };
  services.gnome.gnome-keyring.enable = true;

  # security.pam.services.polkit.enableGnomeKeyring = true;
  # security.pam.services.polkit-soteria.enableGnomeKeyring = true;
  # security.pam.services.ssh-agent.enableGnomeKeyring = true;
  # security.pam.services.gpg-agent.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    seahorse
    age
    inputs.agenix.packages.${pkgs.system}.default
    lxqt.lxqt-policykit
  ];
}
