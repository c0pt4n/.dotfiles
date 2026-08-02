{
  description = "root NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    ...
  }@inputs:
  let
    mkSystem = { host, user }: nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        custom = {
          systemInfo = {
            inherit host user;
            stateVersion = "26.11";
          };
        };
      };
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        ./modules
        ./hosts/${host}
      ];
    };
  in{
    nixosConfigurations = {
      pwnbox = mkSystem {
        host = "pwnbox";
        user = "omar";
      };
    };
  };
}
