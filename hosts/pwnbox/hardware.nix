{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    kernelModules = [
      "kvm-intel"
      "i915"
    ];
    extraModulePackages = [ ];
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    enableAllFirmware = lib.mkDefault true;
    enableRedistributableFirmware = lib.mkDefault config.hardware.enableAllFirmware;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # VA_API (iHD) userspace
        vpl-gpu-rt         # oneVPL (QSV) runtime
        libvdpau-va-gl     # VDPAU-only apps
      ];
    };
    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.production;
      nvidiaSettings = true;
      powerManagement.enable = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          ControllerMode = "bredr";
          Experimental = true;
          FastConnectable = true;
          ClassicBondedOnly = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
    i2c = {
      enable = true;
      group = "i2c";
    };
  };

  environment.variables = lib.mkIf config.hardware.graphics.enable {
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
  };
}
