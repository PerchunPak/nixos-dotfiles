{ inputs, ... }:
{
  imports = with inputs; [ nix-index-database.hmModules.nix-index ];

  programs = {
    command-not-found.enable = false;
    nix-index-database.comma.enable = true;
  };
}
