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
        extensions = with rycee-nur.firefox-addons; [
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
          "browser.sessionstore.max_resumed_crashes" = -1;
        };
      };
      stuff = {
        id = 1;
        extensions = with rycee-nur.firefox-addons; [
          bitwarden
          ublock-origin
        ];
      };
    };
  };

  # Autostart firefox
  xdg.configFile."autostart/firefox.desktop".source =
    "${config.programs.firefox.package}/share/applications/firefox.desktop";

  my.persistence.directories = [
    ".mozilla"
    ".cache/mozilla"
  ];
}
