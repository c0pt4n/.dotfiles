{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.burpsuitepro.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
