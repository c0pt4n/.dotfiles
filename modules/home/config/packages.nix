{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    # wayland & desktop
    wl-clipboard
    wl-mirror
    wlr-randr
    wdisplays
    wayvnc
    wev
    lswt
    libnotify

    # audio
    wiremix
    helvum

    # cli tools
    android-tools
    bc
    jq
    buku
    tree-sitter
    fribidi
    dragon-drop
    ffmpeg
    imagemagick
    exiftool
    firejail
    bubblewrap
    croc
    qrencode
    zbar
    minisign
    signify
    hashcat
    duf
    entr

    # networking
    mitmproxy
    bettercap
    wireshark
    termshark
    aircrack-ng
    proxychains-ng
    netcat-openbsd
    macchanger
    mosh
    wrk
    tor
    torsocks
    transmission_4

    # apps
    gimp
    krita
    #blender
    lmms
    libreoffice
    telegram-desktop
    equibop
    localsend
    #rustdesk

    # dev
    gcc
    gnumake
    ninja
    clang-tools
    valgrind
    zig
    lua
    nodejs
    patch
    patchelf
    pkgconf
    socat
    strace
    grex
    sqlmap
    tokei
    xxd
    radare2
    iaito
    janet
    ruff
    rustup
    cmake
    meson
    hyperfine
    hurl
    dive
    delve
    typst
    uv
    usql
    shellcheck
    shfmt
    bash-language-server
    pnpm
    nixd

    # security
    arp-scan
    subfinder
    nuclei
    nuclei-templates
    httpx
    shuffledns
    frida-tools
    metasploit
    seclists
    nmap
    masscan
    massdns
    thc-hydra
    ghidra
    hcxdumptool
    hcxtools
    dig
    caido-cli
    caido-desktop
  ];

  programs.pandoc = {
    enable = true;
    package = pkgs.pandoc;
  };

  home.sessionVariables = {
    DO_NOT_TRACK = "true";
    GH_TELEMETRY = "false";
    GLAB_SEND_TELEMETRY = "false";
    PYENV_ROOT = "${config.xdg.dataHome}/pyenv";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    PYTHON_HISTORY = "${config.xdg.stateHome}/python_history";
    ANDROID_HOME = "${config.xdg.dataHome}/android/sdk";
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    ANDROID_AVD_HOME = "${config.xdg.dataHome}/android/avd";
    ADB_VENDOR_KEYS = "${config.xdg.dataHome}/android/adbkeys";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
  };
}
