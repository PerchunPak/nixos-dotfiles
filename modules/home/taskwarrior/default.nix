{ pkgs, ... }:
{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;

    config = {
      uda.priority.values = "H,M,,L";
      urgency.uda.priority.L.coefficient = -0.1;
    };
  };

  my.persistence.directories = [
    ".local/share/task"
  ];
}
