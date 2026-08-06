{
  lib,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      extensions = {
        force = true;
      };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
        order = [
          "ddg"
          "google"
          "youtube"
          "wikipedia"
        ];
        engines = {
          bing.metaData.hidden = true;
          google.metaData.alias = "@g";
          youtube = {
            name = "YouTube";
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://youtube.com/favicon.ico";
            definedAliases = [ "@yt" ];
          };
        };
      };

      settings = {
        "accessibility.force_disabled" = 1;
        "accessibility.typeaheadfind.enablesound" = false;
        "browser.uidensity" = 1;
        "browser.theme.content-theme" = 2;
        "browser.startup.couldRestoreSession.count" = 3;
        "browser.sessionhistory.max_total_viewers" = 0;
        "browser.sessionstore.interval" = 30000;
        "browser.sessionstore.interval.idle" = 3600000;
        "browser.sessionhistory.max_entries" = 50;
        "browser.sessionstore.max_serialize_back" = 10;
        "browser.sessionstore.max_serialize_forward" = -1;
        "browser.tabs.min_inactive_duration_before_unload" = 600000;
        "browser.tabs.drawInTitlebar" = true;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.tabs.hoverPreview.enabled" = false;
        "browser.tabs.hoverPreview.showThumbnails" = false;
        "browser.tabs.groups.hoverPreview.enabled" = false;
        "browser.tabs.groups.smart.userEnabled" = false;
        "browser.ml.enable" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.chat.page" = false;
        "browser.ml.chat.page.footerBadge" = false;
        "browser.ml.chat.page.menuBadge" = false;
        "network.prefetch-next" = false;
        "network.http.referer.XOriginPolicy" = 0;
        "privacy.resistFingerprinting" = false;
        "privacy.resistFingerprinting.letterboxing" = false;
        "identity.fxaccounts.enabled" = true;
        "extensions.autoDisableScopes" = 0;
        "extensions.pocket.enabled" = false;
        "extensions.ml.enabled" = false;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "gfx.font_rendering.opentype_svg.enabled" = true;
        "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
        "gfx.webrender.all" = true;
        "media.eme.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "webgl.disabled" = false;
        "general.smoothScroll" = true;
        "sidebar.revamp" = true;
        "sidebar.revamp.round-content-area" = true;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "sidebar.visibility" = "always-show";
        "sidebar.notification.badge.aichat" = false;
        "font.name-list.emoji" = "emoji, Twemoji Mozilla";
      };
    };
  };

  stylix.targets.firefox = lib.mkIf config.programs.firefox.enable {
    colorTheme.enable = true;
    profileNames = [ "default" ];
  };

  home.sessionVariables = lib.mkIf config.programs.firefox.enable {
    BROWSER = "firefox";
  };
}
