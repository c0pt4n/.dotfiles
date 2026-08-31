{
  pkgs,
  lib,
  config,
  ...
}:
let
  configPath = ../files/emacs;
in
{
  home.packages = with pkgs; [
    libtool

    # emacs-everywhere
    wtype
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };
  home.file.".config/emacs" = lib.mkIf (config.programs.emacs.enable && lib.pathExists configPath) {
    source = configPath;
    recursive = true;
  };
  home.shellAliases = lib.mkIf config.programs.emacs.enable {
    emacs = "emacsclient -r -na emacs";
  };
}
