{
  imports = [
    ./programs
    ./themeing.nix
    ../../modules
  ];

  home = {
    homeDirectory = "/Users/wolfmermelstein";
    username = "wolfmermelstein";
    stateVersion = "23.11";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
