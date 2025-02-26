{
  imports = [
    ./options.nix
    ./programs
    ./scripts
    ../../modules
  ];

  home = {
    username = "wolf";
    stateVersion = "23.11";
  };
}
