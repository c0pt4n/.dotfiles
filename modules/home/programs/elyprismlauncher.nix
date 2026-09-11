{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.elyprismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
