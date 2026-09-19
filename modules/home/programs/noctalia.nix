{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    gpu-screen-recorder
    hyprpicker # required for noctalia/color_picker plugin.
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      nightlight.enabled = true;
      location = {
        address = "Cairo, Egypt";
      };
      theme = {
        mode = "dark";
        wallpaper_scheme = "soft";
      };
      audio = {
        enable_sounds = true;
        enable_overdrive = true;
        sound_volume = 1.0;
      };
      dock = {
        reserve_space = false;
        show_dots = true;
        smart_auto_hide = true;
        launcher_position = "end";
      };
      battery = {
        warning_threshold = 20;
      };
      shell = {
        polkit_agent = true;
        screen_time_enabled = true;
        shadow.alpha = 0.15;
        panel = {
          open_near_click_control_center = true;
          open_near_click_session = true;
        };
        session = {
          actions = [
            {
              action = "lock";
              shortcut = "l";
            }
            {
              action = "logout";
              shortcut = "q";
            }
            {
              action = "lock_and_suspend";
              shortcut = "s";
            }
            {
              action = "command";
              command = "systemctl hibernate";
              glyph = "hibernate";
              label = "Hibernate";
              shortcut = "z";
            }
            {
              action = "reboot";
              shortcut = "r";
              variant = "destructive";
            }
            {
              action = "shutdown";
              shortcut = "d";
              variant = "destructive";
            }
          ];
        };
        screenshot = {
          confirm_region = true;
          directory = "${config.xdg.userDirs.pictures}/screenshots";
          filename_pattern = "screenshot_%Y%m%d-%H%M%S";
        };
        launcher = {
          fetch_exchange_rates = false;
          dmenu.entry = {
            passmenu =
              let
                passmenuBin = "${config.xdg.binHome}/passmenu";
              in
              {
                label = "Passwords";
                glyph = "lock";
                prefix = "pass";
                global = false;
                freeform = false;
                command = "${passmenuBin} -l";
                exec = "${passmenuBin} {selection}";
              };
            power-profiles =
              let
                ppcBin = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl";
              in
              {
                label = "Power Profiles";
                glyph = "bolt";
                prefix = "power";
                global = false;
                freeform = false;
                command = "${ppcBin} list | sed -n 's/^\\(\\s\\|\\*\\)\\s\\(.*\\):$/\\2/p'";
                exec = "${ppcBin} set '{selection}'";
              };
          };
        };
      };
      osd = {
        position_vertical = "top_right";
      };
      wallpaper = {
        fill_mode = "stretch";
        fill_color = "surface";
        directory = "${config.xdg.userDirs.pictures}/wallpapers";
      };
      keybinds = {
        cancel = [
          "Escape"
          "Ctrl+c"
        ];
        down = [
          "Down"
          "Ctrl+j"
        ];
        left = [
          "Left"
          "Ctrl+h"
        ];
        right = [
          "Right"
          "Ctrl+l"
        ];
        tab_next = [
          "Tab"
          "Ctrl+n"
        ];
        tab_previous = [
          "Shift+ISO_Left_Tab"
          "Ctrl+p"
        ];
        up = [
          "Up"
          "Ctrl+k"
        ];
      };
      idle = {
        pre_action_fade_seconds = 10;
        behavior = {
          lock = {
            action = "lock";
            timeout = 600;
          };
          screen-off = {
            action = "screen_off";
            timeout = 660;
          };
          suspend = {
            action = "lock_and_suspend";
            timeout = 900;
          };
        };
      };
      bar.default = {
        capsule = true;
        concave_edge_corners = false;
        font_family = config.stylix.fonts.monospace.name;
        font_weight = 700;
        margin_ends = 0;
        radius = 0;
        start = [
          "launcher"
          "workspaces"
        ];
        center = [
          "clock"
          "privacy"
        ];
        end = [
          "group:g1"
          "group:g2"
          "group:g3"
          "group:g4"
        ];
        capsule_group = [
          {
            id = "g1";
            members = [
              "media"
            ];
          }
          {
            id = "g2";
            members = [
              "notifications"
              "tray"
            ];
          }
          {
            id = "g3";
            members = [
              "network"
              "bluetooth"
              "volume"
              "battery"
            ];
          }
          {
            id = "g4";
            members = [
              "clipboard"
              "screenshot"
              "control-center"
            ];
          }
        ];
      };
      lockscreen.fingerprint = false;
      widget = {
        volume.show_label = false;
        network.show_label = false;
        launcher.glyph = "ankh";
        workspaces = {
          capsule_padding = 6;
          capsule_radius = 4;
          empty_color = "on_surface";
          focused_color = "hover";
          hide_when_empty = true;
          labels_only_when_occupied = true;
          occupied_color = "on_surface";
          style = "minimal";
        };
        media = {
          hide_when_no_media = true;
        };
        clock = {
          anchor = true;
          format = "{:%a %H:%M}";
          tooltip_format = "{:%d %b (W%U)}";
          capsule_radius = 4;
          capsule_padding = 10;
        };
        privacy = {
          active_color = "error";
          hide_inactive = true;
        };
        tray = {
          drawer = true;
        };
      };
      lockscreen_widgets =
        let
          kanshiOutputs =
            config.services.kanshi.settings |> lib.map (e: e.output or null) |> lib.filter (o: o != null);
          widgetTemplates = {
            login-box = {
              type = "login_box";
              box_height = 70.0;
              box_width = 400.0;
              fx = 0.5;
              fy = 608.0 / 864.0;
              settings = {
                layout = "compact";
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12.0;
                center_password_text = false;
                input_opacity = 1.0;
                input_radius = 6.0;
                show_caps_lock = true;
                show_keyboard_layout = true;
                show_login_button = true;
              };
            };
            clock-date = {
              type = "clock";
              box_height = 40.0;
              box_width = 100.0;
              fx = 0.5;
              fy = 200.0 / 864.0;
              settings = {
                background = false;
                clock_style = "digital";
                format = "{:%a, %b %e}";
                shadow = true;
              };
            };
            clock-time = {
              type = "clock";
              box_height = 40.0;
              box_width = 200.0;
              fx = 0.5;
              fy = 240.0 / 864.0;
              rotation = 0.0;
              settings = {
                background = false;
                clock_style = "digital";
                format = "{:%H:%M}";
                shadow = true;
              };
            };
            media-player = {
              type = "media_player";
              box_height = 168.0;
              box_width = 328.0;
              fx = 0.5;
              fy = 0.5;
              rotation = 0.0;
              settings = {
                background = true;
                color = "on_surface";
                hide_when_no_media = true;
                layout = "horizontal";
                shadow = true;
              };
            };
          };
          mkWidgetsForOutput =
            output:
            let
              dims = lib.splitString "x" output.mode;
              physWidth = lib.toInt (lib.elemAt dims 0);
              physHeight = lib.toInt (lib.elemAt dims 1);
              scale = output.scale or 1.0;
              logicalWidth = physWidth / scale;
              logicalHeight = physHeight / scale;
            in
            lib.mapAttrs' (
              name: widget:
              let
                widgetDef =
                  lib.removeAttrs widget [
                    "fx"
                    "fy"
                  ]
                  // {
                    output = output.criteria;
                    cx = logicalWidth * widget.fx;
                    cy = logicalHeight * widget.fy;
                  };
              in
              lib.nameValuePair "${name}@${output.criteria}" widgetDef
            ) widgetTemplates;
        in
        {
          enabled = true;
          grid = {
            cell_size = 8;
            major_interval = 4;
            visible = true;
          };
          widget = lib.foldl' (acc: output: acc // (mkWidgetsForOutput output)) { } kanshiOutputs;
        };
      plugins = {
        auto_update = "none";
        source = [
          {
            enabled = true;
            kind = "git";
            location = "https://github.com/noctalia-dev/official-plugins";
            name = "official";
          }
          {
            enabled = true;
            kind = "git";
            location = "https://github.com/noctalia-dev/community-plugins";
            name = "community";
          }
        ];
        enabled = [
          "noctalia/bongocat"
          "noctalia/screen_recorder"
          "oldirtty/color_picker"
        ];
      };
    };
  };

  wayland.windowManager.mango.settings.exec-once =
    lib.mkIf config.wayland.windowManager.mango.enable
      [
        "${config.programs.noctalia.package}/bin/noctalia"
      ];

  wayland.windowManager.niri.settings.spawn-at-startup =
    lib.mkIf config.wayland.windowManager.niri.enable
      [
        "${config.programs.noctalia.package}/bin/noctalia"
      ];
}
