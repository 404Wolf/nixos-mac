{pkgs, ...}: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Open a new Kitty terminal
      cmd + shift - t : open -na "Kitty"

      # Open Obsidian
      cmd + shift - o : open -a "Obsidian"

      # Open Firefox
      cmd + shift - f : open -na "Firefox"

      # Open Google Chrome
      cmd + shift + alt - f : open -na "Google Chrome"
    '';
  };

  # Enable skhd package
  environment.systemPackages = with pkgs; [skhd];
}
