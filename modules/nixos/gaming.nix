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
      gamescope
      mangohud
    ];
  };

  programs.gamemode.enable = true;

  # Gamescope system module (sets capabilities like cap_sys_nice for scheduling & WSI wrappers)
  programs.gamescope = {
    enable = true;
    enableWsi = true;
  };
}
