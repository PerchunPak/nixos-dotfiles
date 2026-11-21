{ nixosConfig, ... }:
{
  services.arrpc.enable = nixosConfig.my.gui.enable;

  programs.equibop = {
    enable = nixosConfig.my.gui.enable;
    settings = {
      arRPC = true;
      discordBranch = "stable";
      minimizeToTray = false;
      splashColor = "rgb(243, 241, 238)";
      splashBackground = "rgb(7, 12, 23)";
    };
    # nix-instantiate --eval -E 'with (import <nixpkgs> {}).lib; fromJSON (readFile ./settings/settings.json)' | nixfmt - > ~/dotfiles/modules/home/equibop/settings.nix
    equicord.settings = import ./settings.nix;
  };

  my.persistence.directories = [ ".config/equibop" ];
}
