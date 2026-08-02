{
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
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
    };
  };
}
