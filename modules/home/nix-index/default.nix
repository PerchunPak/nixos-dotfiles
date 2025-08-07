{ inputs, ... }:
{
  imports = with inputs; [ nix-index-database.homeModules.nix-index ];

  programs = {
    command-not-found.enable = false;
    nix-index-database.comma.enable = true;
  };

  my.persistence.directories = [ ".local/state/comma" ];
}
