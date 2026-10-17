{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.xdg.portal;
  homeDir = config.home.homeDirectory;
  iniFormat = pkgs.formats.ini { };
  noctaliaBin = "${config.programs.noctalia.package}/bin/noctalia";
in
{
  xdg = {
    enable = true;
    localBinInPath = true;
    configHome = "${homeDir}/.config";
    cacheHome = "${homeDir}/.cache";
    dataHome = "${homeDir}/.local/share";
    stateHome = "${homeDir}/.local/state";
    binHome = "${homeDir}/.local/bin";
    portal = {
      enable = true;
      config = {
        common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.Secret" =
            if config.services.gnome-keyring.enable then "gnome-keyring" else "none";
          "org.freedesktop.impl.portal.Inhibit" = "none";
        };
      };
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    terminal-exec.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = false;
      desktop = "${homeDir}";
      projects = "${homeDir}/src";
      download = "${homeDir}/dls";
      documents = "${homeDir}/docs";
      publicShare = "${homeDir}/docs/share";
      templates = "${homeDir}/docs/templates";
      music = "${homeDir}/docs/music";
      videos = "${homeDir}/docs/vids";
      pictures = "${homeDir}/docs/pics";
    };
    mimeApps = {
      enable = true;
    };
  };

  xdg.configFile."xdg-desktop-portal-wlr/config" =
    lib.mkIf (cfg.enable && config.programs.noctalia.enable)
      {
        source = iniFormat.generate "xdg-desktop-portal-wlr-config.ini" {
          screencast = {
            max_fps = 60;
            chooser_type = "dmenu";
            chooser_cmd = "${noctaliaBin} dmenu -p 'Select source'";
            force_mod_linear = 1;
          };
        };
      };
}
