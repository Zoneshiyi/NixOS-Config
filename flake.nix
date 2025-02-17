{
  description = "NixOS configuration of zone";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-24_11.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    swww.url = "github:LGFae/swww";

    agenix.url = "github:ryantm/agenix";
    secrets = {
      url = "git+ssh://git@gitee.com/Zoneshiyi/secrets.git";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-24_11,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      # 系统层面modules的特殊参数
      specialArgs = {
        inherit inputs;
        pkgs-24_11 = import nixpkgs-24_11 {
          inherit system;
          config.allowUnfree = true;
        };
      };
      home-manager-zone.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.zone = import ./users/zone/home.nix;
        # home-manager的特殊参数
        extraSpecialArgs = {
          userhome = "/home/zone";
        } // specialArgs;
      };
      home-manager-root.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.root = import ./users/root/home.nix;
        # home-manager的特殊参数
        extraSpecialArgs = {
          userhome = "/root";
        } // specialArgs;
      };
      base-modules = [
        home-manager.nixosModules.home-manager
        home-manager-zone
        home-manager.nixosModules.home-manager
        home-manager-root
        # ./secrets
      ];
    in
    {
      nixosConfigurations.i512600kf-2070s = nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
          ./hosts/i512600kf-2070s
        ] ++ base-modules;
      };
      nixosConfigurations.dell-i713700 = nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
          ./hosts/dell-i713700
        ] ++ base-modules;
      };
      nixosConfigurations.amd4800hs-2060maxq = nixpkgs.lib.nixosSystem {
        inherit specialArgs system;
        modules = [
          ./hosts/amd4800hs-2060maxq
        ] ++ base-modules;
      };
    };

}
