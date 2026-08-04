{
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./gaming.nix
    ./locale.nix
    ./packages.nix
    ./services.nix
    ./users.nix
  ];

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
