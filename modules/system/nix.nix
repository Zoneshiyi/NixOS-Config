{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "@wheel" ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    extra-substituters = [
      "https://zoneshiyi.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extra-trusted-public-keys = [
      "zoneshiyi.cachix.org-1:lEJ8pJccD7CmzFgo+ZrKM5vi8h6+dosW0HLEzgvHlIE="
    ];
  };
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  environment.variables = {
    NIX_PATH = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.channel.enable = false;
  programs = {
    nix-ld.enable = true;
    command-not-found.enable = false;
  };
}
