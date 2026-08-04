{
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    extraPackages = with pkgs; [
      gamescope # Valve's custom compositor
      mangohud  # FPS & performance overlay
    ];

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;

  # Gamescope system module (sets capabilities like cap_sys_nice for scheduling & WSI wrappers)
  programs.gamescope = {
    enable = true;
    enableWsi = true; # Required for HDR in Wayland / Niri
    capSysNice = true; # Allows Gamescope to request real-time scheduling priority
  };
}
