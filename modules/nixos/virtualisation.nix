{
  pkgs,
  lib,
  ...
}:
{
  virtualisation = {
    waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    docker = {
      enable = true;
      storageDriver = "overlay2";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    vmware.host.enable = true;
  };

  systemd.services.waydroid-container.wantedBy = lib.mkForce [ ];
}
