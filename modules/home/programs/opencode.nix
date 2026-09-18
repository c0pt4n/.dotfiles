{
  pkgs,
  ...
}:
let
  newPkgs =
    (builtins.getFlake "github:nixos/nixpkgs/99b76fd9b396189197d2ecce519ab6d7cd522ab5")
    .legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = [ pkgs.sqlite ];
  programs.opencode = {
    enable = true;
    package = newPkgs.opencode;
    enableMcpIntegration = true;
    settings = {
      permission = {
        bash = "ask";
      };
      experimental = {
        disable_paste_summary = true;
      };
    };
  };
}
