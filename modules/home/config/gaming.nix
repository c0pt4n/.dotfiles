{
  pkgs,
  config,
  ...
}:

{
  # User gaming packages
  home.packages = with pkgs; [
    wineWow64Packages.stagingFull
    winetricks
    protonplus

    # Heroic with GStreamer and Vulkan extras (Single overridden package!)
    (heroic.override {
      extraPkgs =
        pkgs: with pkgs; [
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-good
          gst_all_1.gst-plugins-bad
          gst_all_1.gst-plugins-ugly
          gst_all_1.gst-libav
          vulkan-loader
          vulkan-tools
          vulkan-validation-layers
          vkd3d
          vkd3d-proton
          gamemode
        ];
    })
  ];

  home.file.".config/heroic/tools/proton/Proton-GE".source = "${pkgs.proton-ge-bin.steamcompattool}";

  # Optional: Declaratively configure MangoHud (FPS/Temp Overlay)
  programs.mangohud = {
    enable = true;
    settings = {
      no_display = true;
      fps_limit = "0";
      cpu_temp = true;
      gpu_temp = true;
      ram = true;
      vram = true;
      fps = true;
      frametime = true;
      toggle_hud = "F10";
    };
  };

  home.sessionVariables = {
    WINEPREFIX = "${config.xdg.dataHome}/wineprefixes/default";
  };
}
