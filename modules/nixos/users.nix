{
  pkgs,
  config,
  lib,
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
        "video"
        "audio"
        "kvm"
	  ]
      ++ lib.lists.optional config.hardware.i2c.enable "i2c"
      ++ lib.lists.optional config.services.printing.enable "lp"
      ++ lib.lists.optional config.networking.networkmanager.enable "networkmanager"
      ++ lib.lists.optional (config.users.groups ? adbusers) "adbusers";
	};
	groups.${custom.systemInfo.user} = {};
  };
}
