{
  lib,
  config,
  pkgs,
  ...
}:

let
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
  home.file.".config/nvim" = lib.mkIf (config.programs.neovim.enable && lib.pathExists configPath) {
    source = ../files/nvim;
    recursive = true;
  };
  home.shellAliases = lib.mkIf config.programs.neovim.enable {
    vi = "nvim --noplugin";
  };
}
