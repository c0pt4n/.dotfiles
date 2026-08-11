{
  services.kanshi = {
    enable = true;
    settings = [
      {
        output = {
          criteria = "eDP-1";
          mode = "1920x1080";
          scale = 1.25;
        };
      }
      {
        profile = {
          name = "laptop";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
