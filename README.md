# My NixOS dotfiles

If you don't know what is NixOS, please read [this](https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution).
TLDR: I can rebuild my system from scratch with a few commands on a new PC.

## Installation

I prefer to install NixOS from ISO with some GUI, though any should work as well.

```bash
nix-env -iA nixos.git nixos.neovim
git clone https://github.com/PerchunPak/nixos-dotfiles
cd nixos-dotfiles
# Format disk; also modify device name if needed
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko ./systems/x86_64-linux/perchun-pc/disko.nix --arg device '"/dev/nvme0n1"'
sudo nixos-generate-config --root /mnt
sudo rm -rf /mnt/etc/nixos
sudo cp -r ~/nixos-dotfiles /mnt/etc/nixos
sudo mkdir -p /mnt/persist/home /mnt/persist/system
sudo chown 1000:100 /mnt/persist/system/home/perchun
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#perchun-pc
reboot
# Done!
```
