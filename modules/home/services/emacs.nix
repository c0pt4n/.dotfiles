{
  config,
  ...
}:
{
  services.emacs = {
    enable = config.programs.emacs.enable;
    package = config.programs.emacs.finalPackage;
    defaultEditor = true;
    client = {
      enable = true;
      arguments = [
        "-n"
        "-r"
        "-a"
        "emacs"
      ];
    };
    socketActivation.enable = false;
    startWithUserSession = !config.services.emacs.socketActivation.enable;
  };
}
