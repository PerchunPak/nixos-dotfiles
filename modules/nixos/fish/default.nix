# to make fish default shell, we unfortunately need to install it on system level
{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.users = {
    perchun = {
      shell = pkgs.fish;
    };
  };
}
