{
  inputs,
  custom,
  ...
}:

{
  imports = [ ./nixos ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit inputs custom; };
    users.${custom.systemInfo.user} = ./home;
  };
}
