{ config, ... }:
{
  services.arrpc.enable = config.my.gui.enable;

  programs.equibop = {
    enable = config.my.gui.enable;
    settings = {
      arRPC = true;
      discordBranch = "stable";
      minimizeToTray = false;
    };
    # nix-instantiate --eval -E 'with (import <nixpkgs> {}).lib; fromJSON (readFile ./settings/settings.json)' | nixfmt > ~/dotfiles/modules/home/equibop/settings.nix
    equicord.settings = import ./settings.nix;
  };

  my.persistence.directories = [ ".config/equibop" ];
}
