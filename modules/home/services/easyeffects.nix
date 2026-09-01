{
  services.easyeffects = {
    enable = true;
    settings = {
      StreamInputs = {
        plugins="echo_canceller#0,rnnoise#0";
      };
      Window = {
        showTrayIcon = false;
      };
    };
  };
}
