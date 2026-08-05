{
  home.sessionVariables.BROWSER = "firefox";
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
}
