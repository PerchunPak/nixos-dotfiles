{
  pkgs,
  config,
  inputs,
  ...
}:
let
  rycee-nur = import "${inputs.rycee-nur}" { inherit pkgs; };
in
{
  imports = [ ./ublock-origin.nix ];

  programs.firefox = {
    enable = true;
    profiles = {
      perchun = {
        extensions.packages = with rycee-nur.firefox-addons; [
          bitwarden
          darkreader
          disable-javascript
          enhancer-for-youtube
          grammarly
          languagetool
          refined-github
          simple-tab-groups
          sponsorblock
          stylus
          ublacklist
          ublock-origin
          vimium
        ];

        settings = {
          "browser.download.lastDir" = "/home/perchun/Downloads";
          "browser.sessionstore.max_resumed_crashes" = -1;
        };
      };
      stuff = config.programs.firefox.profiles.perchun // {
        id = 1;
      };
    };
  };

  my.persistence.directories = [
    ".mozilla"
    ".cache/mozilla"
  ];
}
