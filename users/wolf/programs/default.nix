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
    ./xdg.nix
    ./firefox
    ./vscode
    ./thunderbird
  ];

  programs.home-manager.enable = true;
}
