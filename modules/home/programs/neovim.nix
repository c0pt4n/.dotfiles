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
    defaultEditor = true;
    waylandSupport = pkgs.stdenv.isLinux;
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
