{
  config,
  ...
}:
{
  programs.claude-code = {
    enable = true;
    configDir = "${config.xdg.configHome}/claude";
  };
}
