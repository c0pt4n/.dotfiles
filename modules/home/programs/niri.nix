{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
let
  noctaliaBin = "${config.programs.noctalia.package}/bin/noctalia";
  terminalBin =
    if config.home.sessionVariables ? TERMINAL then
      config.home.sessionVariables.TERMINAL
    else if config.xdg.terminal-exec.enable then
      "${config.xdg.terminal-exec.package}/bin/xdg-terminal-exec"
    else
      throw "No terminal emulator found";
  zoomerScript = pkgs.writeShellScript "zoomer-script" ''
    set -eu
    mon="$(niri msg --json focused-output | ${pkgs.jq}/bin/jq -r ".name")"
    ${pkgs.woomer}/bin/woomer --monitor "$mon" --output "$mon"
  '';
  oldPkgs =
    (builtins.getFlake "github:nixos/nixpkgs/a5cbcfe954791221bfffe2307f7d1a1bf61a871e")
    .legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = lib.mkIf osConfig.programs.niri.enable (
    with pkgs;
    [
      oldPkgs.xwayland-satellite
      nautilus
    ]
  );

  wayland.windowManager.niri = {
    enable = osConfig.programs.niri.enable;
    xwaylandSatellitePackage = oldPkgs.xwayland-satellite;
    checkConfig = true;
    settings = {
      gestures.hot-corners.off = { };
      cursor.hide-when-typing = { };
      hotkey-overlay.skip-at-startup = { };
      prefer-no-csd = { };

      environment = {
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        QT_QPA_PLATFORM = "wayland;xcb";
        ELM_DISPLAY = "wl";
        MOZ_ENABLE_WAYLAND = "1";
        NO_AT_BRIDGE = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        AWT_TOOLKIT = "MToolkit";
      };

      layout = {
        gaps = 10;
        focus-ring = {
          width = 2;
          active-color = "#${config.lib.stylix.colors.base0D}";
          inactive-color = "#${config.lib.stylix.colors.base03}";
          urgent-color = "#${config.lib.stylix.colors.base08}";
        };
        border.off = { };
      };

      input = {
        disable-power-key-handling = { };
        focus-follows-mouse = {
          _props.max-scroll-amount = "0%";
        };
        mod-key = "Super";
        mod-key-nested = "Alt";
        keyboard = {
          xkb = {
            layout = "us,ara";
            options = "grp:alt_space_toggle,grp_led:caps,altwin:menu_win";
          };
          repeat-rate = 50;
          repeat-delay = 200;
        };
        touchpad = {
          tap = { };
        };
      };

      binds = {
        "Mod+1".focus-workspace = 1;
        "Mod+2".focus-workspace = 2;
        "Mod+3".focus-workspace = 3;
        "Mod+4".focus-workspace = 4;
        "Mod+5".focus-workspace = 5;
        "Mod+6".focus-workspace = 6;
        "Mod+7".focus-workspace = 7;
        "Mod+8".focus-workspace = 8;
        "Mod+9".focus-workspace = 9;

        "Mod+Shift+1".move-column-to-workspace = 1;
        "Mod+Shift+2".move-column-to-workspace = 2;
        "Mod+Shift+3".move-column-to-workspace = 3;
        "Mod+Shift+4".move-column-to-workspace = 4;
        "Mod+Shift+5".move-column-to-workspace = 5;
        "Mod+Shift+6".move-column-to-workspace = 6;
        "Mod+Shift+7".move-column-to-workspace = 7;
        "Mod+Shift+8".move-column-to-workspace = 8;
        "Mod+Shift+9".move-column-to-workspace = 9;

        "Mod+Shift+Q".quit = { };
        "Mod+Shift+C" = {
          _props.repeat = false;
          close-window = { };
        };
        "Mod+Return" = {
          _props.repeat = false;
          spawn = [ "${terminalBin}" ];
        };
        "Mod+Z" = {
          _props.repeat = false;
          spawn = [ "${zoomerScript}" ];
        };

        "Mod+J".focus-workspace-down = { };
        "Mod+K".focus-workspace-up = { };
        "Mod+L".focus-column-right = { };
        "Mod+H".focus-column-left = { };

        "Mod+Shift+J".move-column-to-workspace-down = { };
        "Mod+Shift+K".move-column-to-workspace-up = { };
        "Mod+Shift+L".move-column-right = { };
        "Mod+Shift+H".move-column-left = { };

        "Mod+Alt+H".consume-window-into-column = { };
        "Mod+Alt+L".expel-window-from-column = { };

        "Mod+Down".focus-workspace-down = { };
        "Mod+Up".focus-workspace-up = { };
        "Mod+Right".focus-column-right = { };
        "Mod+Left".focus-column-left = { };

        "Mod+Shift+Right".move-column-right = { };
        "Mod+Shift+Left".move-column-left = { };

        "Mod+F".maximize-column = { };
        "Mod+Shift+F".fullscreen-window = { };
        "Mod+Alt+F".maximize-window-to-edges = { };
        "Mod+Shift+O" = {
          _props.repeat = false;
          toggle-overview = { };
        };

        "Mod+Shift+Space".toggle-window-floating = { };
        "Mod+Space".switch-focus-between-floating-and-tiling = { };

        "Mod+Ctrl+B" = {
          _props.repeat = false;
          spawn = [
            "${terminalBin}"
            "-a"
            "btop"
            "-e"
            "btop"
          ];
        };

        "Mod+Escape".spawn = [
          "${noctaliaBin}"
          "msg"
          "panel-open"
          "control-center"
        ];
        "Mod+R".spawn = [
          "${noctaliaBin}"
          "msg"
          "panel-open"
          "launcher"
        ];
        "Mod+Q".spawn = [
          "${noctaliaBin}"
          "msg"
          "panel-open"
          "session"
        ];
        "Print".spawn = [
          "${noctaliaBin}"
          "msg"
          "screenshot-fullscreen"
          "pick"
        ];
        "Ctrl+Print".spawn = [
          "${noctaliaBin}"
          "msg"
          "screenshot-region"
        ];
        "Mod+O".spawn = [
          "${noctaliaBin}"
          "msg"
          "panel-open"
          "clipboard"
        ];
        "Mod+Backslash".spawn = [
          "${noctaliaBin}"
          "msg"
          "notification-clear-active"
        ];
        "Mod+Shift+Backslash".spawn = [
          "${noctaliaBin}"
          "msg"
          "notification-dnd-toggle"
        ];
        "XF86PowerOff".spawn = [
          "${noctaliaBin}"
          "msg"
          "panel-open"
          "session"
        ];

        "XF86MonBrightnessUp" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "brightness-up"
            "all"
            "5"
          ];
        };
        "XF86MonBrightnessDown" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "brightness-down"
            "all"
            "5"
          ];
        };
        "XF86AudioRaiseVolume" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "volume-up"
            "5"
          ];
        };
        "XF86AudioLowerVolume" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "volume-down"
            "5"
          ];
        };
        "XF86AudioMute" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "volume-mute"
          ];
        };
        "XF86AudioMicMute" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "mic-mute"
          ];
        };
        "Mod+Equal" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "volume-up"
            "5"
          ];
        };
        "Mod+Minus" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "volume-down"
            "5"
          ];
        };
        "Mod+Backspace" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "volume-mute"
          ];
        };
        "Mod+Ctrl+Backspace" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "mic-mute"
          ];
        };
        "XF86AudioNext" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "media"
            "next"
          ];
        };
        "XF86AudioPrev" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "media"
            "previous"
          ];
        };
        "XF86AudioPlay" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "media"
            "toggle"
          ];
        };
        "Mod+Shift+Equal" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "media"
            "next"
          ];
        };
        "Mod+Shift+Minus" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "media"
            "previous"
          ];
        };
        "Mod+Shift+Backspace" = {
          _props.allow-when-locked = true;
          spawn = [
            "${noctaliaBin}"
            "msg"
            "media"
            "toggle"
          ];
        };
        "Mod+Comma".focus-monitor-previous = { };
        "Mod+Period".focus-monitor-next = { };
      }
      // lib.optionalAttrs config.programs.emacs.enable (
        let
          pkg = config.programs.emacs.finalPackage;
          bin = "${pkg}/bin/emacs";
          cmd = if config.services.emacs.enable then "${pkg}/bin/emacsclient -nca ${bin}" else bin;
        in
        {
          "Mod+E".spawn-sh = cmd;
          "Mod+Shift+E".spawn = [
            "emacsclient"
            "-ne"
            "(oceanic/new-frame-with-ghostel)"
          ];
        }
      );
      _children = [
        {
          window-rule._children = [
            { geometry-corner-radius = 6; }
            { clip-to-geometry = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "(discord|vesktop|equibop)$"; }
            { match._props.app-id = "firefox"; }
            { match._props.app-id = "^steam$"; }
            { match._props.app-id = "heroic"; }
            { match._props.app-id = "btop"; }
            { match._props.app-id = "Vmware"; }
            { open-maximized = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "emacs"; }
            { open-maximized-to-edges = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props.title = "Picture-in-Picture"; }
            { match._props.app-id = "scrcpy"; }
            { open-floating = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "(discord|vesktop|equibop)$"; }
            { match._props.app-id = "org.telegram.desktop"; }
            { open-on-workspace = "social"; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "firefox"; }
            { match._props.app-id = "chromium-browser"; }
            { open-on-workspace = "web"; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "emacs"; }
            { open-on-workspace = "dev"; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "^steam$"; }
            { match._props.app-id = "heroic"; }
            { open-on-workspace = "gaming"; }
          ];
        }
        { workspace._args = [ "social" ]; }
        { workspace._args = [ "web" ]; }
        { workspace._args = [ "dev" ]; }
        { workspace._args = [ "gaming" ]; }
      ];
    };
  };
}
