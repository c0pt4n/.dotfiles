{
  imports = [
    ./boot.nix
    ./locale.nix
    ./packages.nix
    ./services.nix
    ./users.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
