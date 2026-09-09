{
  pkgs,
  config,
  ...
}:
{
  programs.mcp = {
    enable = config.programs.opencode.enable;
    servers = {
      burp = {
        command = "${pkgs.jdk}/bin/java";
        args = [
          "-jar"
          "${config.xdg.userDirs.projects}/mcp/mcp-proxy.jar"
          "--sse-url"
          "http://127.0.0.1:9876"
        ];
      };
    };
  };
}
