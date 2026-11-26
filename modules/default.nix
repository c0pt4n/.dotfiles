{
  inputs,
  custom,
  ...
}: {
  imports = [./nixos];

  nixpkgs.overlays = [
    inputs.emacs-overlay.overlays.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs custom;};
    users.${custom.systemInfo.user} = ./home;
  };
}
