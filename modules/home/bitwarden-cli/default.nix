{ pkgs, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://bw.perchun.it";
      email = "bw@perchun.it";
      pinentry = pkgs.pinentry-rofi;
    };
  };

  my.persistence.directories = [
    ".local/share/rbw"
    ".cache/rbw"
  ];
}
