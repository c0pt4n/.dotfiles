{
  description = "root NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
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
