{
  description = "root NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
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
