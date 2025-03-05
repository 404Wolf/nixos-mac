{
  imports = [
    ./apple.nix
    ./skhd.nix
  ];

  system.checks.verifyNixPath = false;

  users.users.wolfmermelstein = {
    name = "wolfmermelstein";
    home = "/Users/wolfmermelstein";
  };

  ids.gids.nixbld = 350;

  system. stateVersion = 4;
  services.tailscale.enable = true;
  services.openssh.enable = true;
}
