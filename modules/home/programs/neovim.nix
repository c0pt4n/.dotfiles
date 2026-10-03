{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.programs.neovim;
  configPath = ../files/nvim;
in
{
  programs.neovim = {
    enable = true;
    waylandSupport = pkgs.stdenv.hostPlatform.isLinux;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPerl = false;
    withNodeJs = false;
    withPython3 = false;
  };
  home.file.".config/nvim" = lib.mkIf (cfg.enable && lib.pathExists configPath) {
    source = ../files/nvim;
    recursive = true;
  };
  home.shellAliases = lib.mkIf cfg.enable {
    vi = "nvim --noplugin";
  };
}
