{ pkgs, ... }:
{
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/arctracker-link" = "arctracker-link.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/arctracker-link" = "arctracker-link.desktop";
    };
  };

  home.packages = [ pkgs.my.arctracker-link ];

  my.persistence.directories = [
    ".cache/arctracker-link"
    ".local/state/arctracker-link"
    ".local/state/arctracker-link"
  ];
}
