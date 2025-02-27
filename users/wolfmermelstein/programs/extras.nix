{pkgs, ...}: {
  home.packages = with pkgs; [
    # System Utilities
    curl
    wget
    tree
    tmux
    openssl
    yubikey-manager
    htop
    cloudflared
    speedtest-cli

    # Networking & File Management
    rclone
    xdg-utils

    # Development & Programming Tools
    gcc
    cargo
    delve
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
    zotero
    evince

    # Graphics & Media
    gimp
    inkscape
    mpv
    feh

    # Browsers & Communication
    google-chrome
    discord
    signal-desktop
    hoppscotch

    # Security & Password Management
    rbw

    # Database Tools
    sqlitebrowser
    gpgme
  ];
}
