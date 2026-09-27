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
    package = pkgs.emacs-unstable-pgtk;
  };

  services.emacs = {
    enable = config.programs.emacs.enable;
    package = config.programs.emacs.finalPackage;
    defaultEditor = true;
    client = {
      enable = true;
      arguments = [
        "-n"
        "-c"
        "-a"
        "emacs"
      ];
    };
    socketActivation.enable = false;
    startWithUserSession = !config.services.emacs.socketActivation.enable;
  };

  home.file.".config/emacs" = lib.mkIf (config.programs.emacs.enable && lib.pathExists configPath) {
    source = configPath;
    recursive = true;
  };

  home.shellAliases = lib.mkIf config.programs.emacs.enable {
    emacs = "emacsclient -nca emacs";
  };

  xdg.mimeApps.defaultApplications = lib.mkIf config.programs.emacs.enable (
    lib.genAttrs [
      "text/plain"
      "text/x-c"
      "text/x-shellscript"
    ] (_: [ "emacsclient.desktop" ])
  );
}
