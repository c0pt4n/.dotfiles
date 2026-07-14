{
  custom,
  pkgs,
  ...
}:

{
  users = {
	users.${custom.systemInfo.user} = {
	  isNormalUser = true;
	  shell = pkgs.zsh;
	  extraGroups = [
		"networkmanager"
		"wheel"
	  ];
	};
	groups.${custom.systemInfo.user} = {};
  };
}
