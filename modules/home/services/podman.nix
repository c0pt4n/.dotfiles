{
  pkgs,
  ...
}:
{
  services.podman = {
    enable = true;
    settings = {
      registries.search = [ "docker.io" ];
      containers.engine.compose_providers = [
        "${pkgs.podman-compose}/bin/podman-compose"
        "${pkgs.docker-compose}/bin/docker-compose"
      ];
    };
  };
}
