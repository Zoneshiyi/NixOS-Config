{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.identityPaths = [
    "/etc/ssh/host_ed25519"
  ];

  age.secrets."encrypt-subkey" = {
    symlink = true;
    file = "${inputs.secrets}/encrypt-subkey.age";
    mode = "0500";
    owner = "zone";
  };
  age.secrets."sign-subkey" = {
    symlink = true;
    file = "${inputs.secrets}/sign-subkey.age";
    mode = "0500";
    owner = "zone";
  };
}
