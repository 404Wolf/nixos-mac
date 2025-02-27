{
  imports = [
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
  ];

  programs.home-manager.enable = true;
}
