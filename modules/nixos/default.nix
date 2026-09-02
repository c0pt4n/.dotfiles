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
    ./virtualisation.nix
  ];

  nix = {
    package = pkgs.nixVersions.latest;
    checkConfig = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      auto-optimise-store = true;
      extra-substituters = [
        "https://noctalia.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
