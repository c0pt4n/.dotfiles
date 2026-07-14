{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    file
    which
    tree
    lm_sensors
    zip
    xz
    unzip
    p7zip
    gnutar
    gnused
    gawk
    btop
    iotop
    iftop
    strace
    ltrace
    traceroute
    lsof
    sysstat
    pciutils
    usbutils
    ethtool
    wget
    zstd
  ];
}
