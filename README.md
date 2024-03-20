# My NixOS dotfiles

If you don't know what is NixOS, please read [this](https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution).
TLDR: I am able to rebuilt my system from scratch in a few commands on a new PC.

## Installation

I prefer to install NixOS from minimal installation ISO, though any should work as well.

```bash
nix-shell -p git neovim
git clone https://github.com/PerchunPak/nixos-dotfiles
cd nixos-dotfiles
# Format disk; also modify device name if needed
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./modules/nixos/disko.nix --arg device '"/dev/vda"'
sudo nixos-generate-config --root /mnt
sudo rm -rf /mnt/etc/nixos
sudo cp ~/nixos-dotfiles /mnt/etc/nixos
sudo nixos-install --root /mnt
# Try to boot into installed OS
reboot
# It won't work for the first time, just type any letter as long as it asks
# if you want to ignore errors
#
# After kernel panic, it will delete all configs and will boot into clear OS
# though without terminal emulator. Press Ctrl Alt F4 to open another TTY.
# Then login into user and type these commands
nix-shell -p git neovim
git clone https://github.com/PerchunPak/nixos-dotfiles ~/dotfiles
cd ~/dotfiles
sudo nixos-rebuild --experimental-features "nix-command flakes" switch --flake .#perchun-pc
```
