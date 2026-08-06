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
          AnonymiseFileNames = {
            enabled = true;
            anonymiseByDefault = false;
          };
          ClearURLs = {
            enabled = true;
          };
          ImageZoom = {
            enabled = true;
          };
          InvisibleChat = {
            enabled = true;
          };
          MessageLatency = {
            enabled = true;
          };
          Moyai = {
            enabled = true;
          };
          PlatformIndicators = {
            enabled = true;
          };
          ServerSearch = {
            enabled = true;
          };
          ShowHiddenChannels = {
            enabled = true;
          };
          ShowHiddenThings = {
            enabled = true;
          };
          SilentTyping = {
            enabled = true;
          };
          Timezones = {
            enabled = true;
          };
          VoiceButtons = {
            enabled = true;
          };
          VoiceChannelLog = {
            enabled = true;
          };
        };
        useQuickCss = true;
      };
    };
  };
}
