{
  pkgs,
  config,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "plymouth.use-simpledrm"
    ];
    plymouth = {
      enable = true;
      theme = "hud_3";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ config.boot.plymouth.theme ];
        })
      ];
    };
  };
}
