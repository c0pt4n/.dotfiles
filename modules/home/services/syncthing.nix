{
  services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8384";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      options = {
        urAccepted = -1;
        natEnabled = false;
        startBrowser = false;
        relaysEnabled = false;
        limitBandwidthInLan = false;
        localAnnounceEnabled = true;
        globalAnnounceEnabled = false;
        crashReportingEnabled = false;
      };
    };
    tray.enable = true;
  };
}
