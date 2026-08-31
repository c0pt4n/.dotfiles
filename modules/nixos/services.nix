{
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.audit.enable = true;

  security.auditd.enable = true;

  services.vnstat.enable = true;

  services.cloudflare-warp.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}
