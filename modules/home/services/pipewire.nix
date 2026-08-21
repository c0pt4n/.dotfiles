{
  services = {
    pipewire = {
      enable = true;
      configs = {
        "10-clock-rate" = {
          context.properties = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [
              44100
              48000
              96000
              192000
            ];
            "default.clock.quantum" = 1024;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 8192;
          };
        };
      };

      wireplumber = {
        enable = true;
        configs = {
          disable-camera = {
            "wireplumber.profiles" = {
              main = {
                "monitor.libcamera" = "disabled";
              };
            };
          };
          disable-suspension = {
            "monitor.alsa.rules" = [
              {
                matches = [
                  {
                    "node.name" = "~alsa_input.*";
                  }
                  {
                    "node.name" = "~alsa_output.*";
                  }
                ];
                actions = {
                  update-props = {
                    "session.suspend-timeout-seconds" = 0;
                  };
                };
              }
            ];
          };
        };
      };
      pulseConfigs = {
        "10-source-volumes" = {
          "pulse.rules" = [
            {
              matches = [
                {
                  "application.name" = "~Chromium.*";
                }
                {
                  "application.name" = "equibop";
                }
              ];
              actions = {
                quirks = [ "block-source-volume" ];
              };
            }
            {
              matches = [
                {
                  "application.process.binary" = "Discord";
                }
              ];
              actions = {
                quirks = [ "block-source-volume" ];
              };
            }
          ];
        };
      };
    };
  };
}
