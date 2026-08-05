{
  lib,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      extensions = {
        force = true;
      };
    };
  };

  stylix.targets.firefox = lib.mkIf config.programs.firefox.enable {
    colorTheme.enable = true;
    profileNames = [ "default" ];
  };

  home.sessionVariables = lib.mkIf config.programs.firefox.enable {
    BROWSER = "firefox";
  };
}
