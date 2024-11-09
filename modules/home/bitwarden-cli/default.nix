{ pkgs, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://bw.perchun.it";
      # identity_url = "https://bw.perchun.it/identity";
      email = "bw@perchun.it";
      pinentry = pkgs.pinentry-rofi;
    };
  };
}
