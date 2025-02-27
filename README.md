# MacNix

Home Manager configuration for macOS with nix-darwin integration.

## Setup

1. Install Nix:
   ```
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

2. Enable flakes:
   ```
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

3. Install nix-darwin:
   ```
   nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
   ./result/bin/darwin-installer
   ```

4. Apply configuration:
   ```
   darwin-rebuild switch --flake .#macbookair
   ```
