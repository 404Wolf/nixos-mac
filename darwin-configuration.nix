{
  config,
  pkgs,
  ...
}: {
  # Auto upgrade nix package and the daemon service
  services.nix-daemon.enable = true;

  # Basic system settings
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };
    
    dock = {
      autohide = true;
      tilesize = 36;
    };
    
    finder = {
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      ShowPathbar = true;
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Used for backwards compatibility
  system.stateVersion = 4;
}