{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  age.identityPaths = [
    "${config.home.homeDirectory}/.ssh/host_ed25519"
  ];

  age.secretsDir = "${config.home.homeDirectory}/Documents/agenix";

  age.secrets."encrypt-subkey" = {
    file = "${inputs.secrets}/encrypt-subkey.age";
    mode = "0500";
  };
  # age.secrets."sign-subkey" = {
  #   file = "${inputs.secrets}/sign-subkey.age";
  #   mode = "0500";
  # };
  home.packages = with pkgs; [
    age
    lux
    aria2
  ];
}
