{
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      theme = {
        dark_name = "terminal";
        name = "terminal";
      };
      keys = {
        split_vertical = "prefix+|";
        last_pane = "prefix+^";
      };
    };
  };
}
