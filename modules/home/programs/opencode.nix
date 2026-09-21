{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.sqlite ];
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      permission = {
        bash = "ask";
      };
      experimental = {
        disable_paste_summary = true;
      };
    };
  };
}
