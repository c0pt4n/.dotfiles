{
  config,
  custom,
  ...
}:
{
  imports = [
    ./config
    ./programs
    ./services
  ];

  programs.home-manager.enable = true;
  home = {
    username = custom.systemInfo.user;
    homeDirectory = "/home/${custom.systemInfo.user}";
    stateVersion = custom.systemInfo.stateVersion;
    preferXdgDirectories = config.xdg.enable;
    enableNixpkgsReleaseCheck = true;
  };
}
