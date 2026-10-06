{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.emacs;
  configPath = ../files/emacs;
in
{
  home.packages = with pkgs; [
    libtool
    poppler-utils

    # emacs-everywhere
    wtype
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable-pgtk;
  };

  services.emacs = {
    enable = cfg.enable;
    package = cfg.finalPackage;
    defaultEditor = true;
    client = {
      enable = true;
      arguments = [
        "-n"
        "-a"
        "emacs"
      ];
    };
    socketActivation.enable = false;
    startWithUserSession = !config.services.emacs.socketActivation.enable;
  };

  home.file.".config/emacs" = lib.mkIf (cfg.enable && lib.pathExists configPath) {
    source = configPath;
    recursive = true;
  };

  home.shellAliases = lib.mkIf cfg.enable {
    emacs = "emacsclient -nca emacs";
  };

  xdg.mimeApps.defaultApplications = lib.mkIf cfg.enable (
    lib.genAttrs [
      "text/plain"
      "text/x-c"
      "text/x-shellscript"
    ] (_: [ "emacsclient.desktop" ])
  );
}
