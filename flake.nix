{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager, ... }:
  let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux" # Most other systems
      "aarch64-darwin" # Apple Silicon
    ];
    inherit (nixpkgs) lib;
    configurationRevision = self.rev or self.dirtyRev or null;
    specialArgs = {
      inherit
        inputs
        outputs
        nixpkgs
        configurationRevision
        ;
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          {
            users.users = import ./users.nix;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.damien = import ./home.nix;
          }
        ];
      };
    };
  };
}