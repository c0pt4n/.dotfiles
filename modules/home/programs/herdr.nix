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
        prefix = "ctrl+a";
        split_vertical = "prefix+|";
        last_pane = "prefix+^";
      };
      ui = {
        toast = {
          delivery = "herdr";
        };
      };
    };
  };
}
