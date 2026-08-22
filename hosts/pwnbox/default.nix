{
  inputs,
  pkgs,
  lib,
  config,
  custom,
  ...
}:

{
  imports = [
    ./hardware.nix
    ./file-system.nix
    ./boot.nix
    inputs.noctalia-greeter.nixosModules.default
  ];

  networking.hostName = custom.systemInfo.host;
  system.stateVersion = custom.systemInfo.stateVersion;

  networking.networkmanager.enable = true;

  networking = {
    wireless = {
      enable = true;
      scanOnLowSignal = true;
    };
    firewall = {
      allowedTCPPorts = [
        22000 # Syncthing TCP sync
        53317 # LocalSend TCP transfer
      ];
      allowedUDPPorts = [
        22000 # Syncthing QUIC sync
        21027 # Syncthing discovery
        53317 # LocalSend UDP discovery
      ]
      ++ lib.optional config.services.tailscale.enable 41641;
    };
  };

  security.polkit.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplipWithPlugin
    ];
  };

  services.tailscale.enable = true;

  services.power-profiles-daemon.enable = true;

  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    allowRiskyCriticalPowerAction = false;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 5;
    timeLow = 1200;
    timeCritical = 300;
    timeAction = 120;
    criticalPowerAction = "HybridSleep";
  };

  programs.dconf.enable = true;

  programs.mangowc.enable = true;

  programs.nix-ld.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run;
  };

  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };

  programs.noctalia-greeter = {
    enable = true;
    greeter-args = "";
    settings = {
      session.default = "mango";
      keyboard.layout = "us";
      idle.timeout = 600;
      appearance.hide_logo = true;
      cursor = {
        package = pkgs.nordzy-cursor-theme;
        name = "Nordzy-cursors";
        size = 32;
      };
    };
  };
}
