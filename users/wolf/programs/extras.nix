{pkgs, ...}: {
  home.packages = with pkgs; [
    # System Utilities
    curl
    wget
    tree
    tmux
    util-linux
    openssl
    yubikey-agent
    yubikey-manager
    htop
    cloudflared
    speedtest-cli
    bluez

    # Networking & File Management
    rclone
    xdg-utils

    # Development & Programming Tools
    gcc
    cargo
    delve
    gdb
    pkg-config
    gnumake
    nodejs_20
    deno
    bun
    mise
    (python3.withPackages (pyPkgs:
      with pyPkgs; [
        numpy
        pandas
        pytest
        pip
      ]))
    typst
    lazygit
    yubikey-personalization-gui
    texliveFull
    pandoc
    code-cursor

    # Text Processing & File Manipulation
    ripgrep
    jq
    fzf
    fd
    perlPackages.FileMimeInfo
    pdftk
    unzip
    zip
    dtrx

    # Monitoring & Analysis
    cloc
    nix-tree
    entr
    nmap
    spotify
    spotube

    # Productivity & Documentation
    tldr
    wrappedNvim
    libreoffice-qt6-still
    zotero
    anki
    evince

    # Graphics & Media
    gimp
    inkscape
    obs-studio
    vlc
    mpv
    feh

    # Browsers & Communication
    google-chrome
    discord
    zulip
    zoom-us
    signal-desktop
    hoppscotch
    beeper

    # Security & Password Management
    bitwarden-desktop
    rbw

    # Database Tools
    sqlitebrowser
    gpgme
  ];
}
