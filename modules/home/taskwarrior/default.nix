{ pkgs, ... }:
{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };

  my.persistence.directories = [
    ".local/share/task"
  ];
}
