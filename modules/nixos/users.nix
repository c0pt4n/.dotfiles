{
  pkgs,
  config,
  custom,
  ...
}:

{
  users = {
	users.${custom.systemInfo.user} = {
	  isNormalUser = true;
	  shell = if config.programs.zsh.enable then pkgs.zsh else pkgs.bashInteractive;
	  extraGroups = [
		"networkmanager"
		"wheel"
	  ];
	};
	groups.${custom.systemInfo.user} = {};
  };
}
