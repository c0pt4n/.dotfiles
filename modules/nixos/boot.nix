{ lib, ... }:

{
  boot = {
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
      cleanOnBoot = true;
    };
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
      "vm.dirty_background_bytes" = 33554432;
      "vm.dirty_bytes" = 134217728;
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = lib.mkDefault 10;
        consoleMode = lib.mkDefault "max";
      };
    };
  };
}
