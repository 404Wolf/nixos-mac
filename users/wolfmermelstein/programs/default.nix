{
  imports = [
    ./vscode
    ./git
    ./tmux
    ./yazi
    ./zsh
    ./extras.nix
    ./gpt.nix
    ./go.nix
    ./direnv.nix
    ./zoxide.nix
    ./firefox
    ./kitty
  ];

  programs.home-manager.enable = true;
}
