{
  programs.equibop={
    enable=true;
    settings={
      appBadge=false;
      arRPC=false;
      checkUpdates=false;
      customTitleBar=false;
      disableMinSize=true;
      minimizeToTray=true;
      tray=true;
      splashBackground="#2e3440";
      splashColor="#d8dee9";
      splashTheming=true;
      staticTitle=true;
      hardwareAcceleration=true;
      discordBranch="stable";
    };
    equicord={
      themes = {
        "nordic" = ''
          @import url("https://raw.githubusercontent.com/orblazer/discord-nordic/master/nordic.vencord.css");
        '';
      };
      settings={
        autoUpdate = false;
        autoUpdateNotification = false;
        disableMinSize = true;
        notifyAboutUpdates = false;
        enabledThemes = [ "nordic.css" ];
        plugins = {
          FakeNitro = {
            enabled = true;
          };
          MessageLogger = {
            enabled = true;
            ignoreSelf = true;
          };
        };
        useQuickCss = true;
      };
    };
  };
}
