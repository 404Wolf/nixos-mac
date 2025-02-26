{
  imports = [
    ./git
    ./tmux
    ./yazi
    ./zsh
    ./extras.nix
    ./gpt.nix
    ./neomutt.nix
    ./rbw.nix
    ./go.nix
    ./direnv.nix
    ./zoxide.nix
    ./fuzzel.nix
    ./dunst.nix
    ./hyprland
    ./waybar
    ./tofi
    ./apps
    ./gtk.nix
    ./xdg.nix
    ./firefox
    ./qutebrowser
    ./kitty
    ./vscode
    ./thunderbird
  ];

  programs.home-manager.enable = true;
}
