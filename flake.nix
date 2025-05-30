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
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    secrets = {
      url = "git+ssh://git@gitee.com/Zoneshiyi/secrets.git";
      flake = false;
    };
  };
  # (outputs {self=inputs;nixpkgs=inputs.nixpkgs;nixpkgs-24_11=inputs.nixpkgs-24_11;home-manager=inputs.home-manager;}).nixosConfigurations
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-24_11,
      home-manager,
      nix-index-database,
      ...
    }:
    let
      system = builtins.currentSystem;
      # 系统层面modules的特殊参数
      specialArgs = {
        inherit inputs;
        pkgs-24_11 = import nixpkgs-24_11 {
          inherit system;
          config.allowUnfree = true;
        };
        configPath = "/home/zone/NixOS/config";
      };
      home-manager-config.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "home-manager.backup";
        users.zone = import ./users/zone/home.nix;
        users.root = import ./users/root/home.nix;
        # home-manager的特殊参数
        extraSpecialArgs = specialArgs;
      };
      base-modules = [
        nix-index-database.nixosModules.nix-index
        home-manager.nixosModules.home-manager
        home-manager-config
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
