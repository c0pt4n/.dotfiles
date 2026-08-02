{
  config,
  lib,
  pkgs,
  custom,
  ...
}:

{
  imports = [
    ./hardware.nix
    ./file-system.nix
    ./boot.nix
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
      ];
    };
  };

  services.printing.enable = true;

  programs.dconf.enable = true;

  programs.mango = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "mango";
        user = "omar"; # auto-login on first start, no password required
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd mango";
        user = "greeter";
      };
    };
  };
}

