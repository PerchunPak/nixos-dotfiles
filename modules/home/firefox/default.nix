{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ ./ublock-origin.nix ];

  programs.firefox = {
    enable = true;
    profiles = {
      perchun = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
          sponsorblock
          limit-limit-distracting-sites
          grammarly
          languagetool
          disable-javascript
          enhancer-for-youtube
          simple-tab-groups

          # was removed from store
          # see https://github.com/vladikoff/netflix-1080p-firefox/issues/63
          # (sus tbh)
          (buildFirefoxXpiAddon {
            pname = "netflix-1080p";
            version = "1.17.0";
            addonId = "{f18f0257-10ad-4ff7-b51e-6895edeccfc8}";
            url = "https://github.com/vladikoff/netflix-1080p-firefox/files/10981084/f18f0257-10ad-4ff7-b51e-6895edeccfc8.zip";
            sha256 = "vT/cdRbwlt3w+0q/Wcxas6bIljCXW2el9JsgPcwHxNI=";
            meta = {
              homepage = "https://github.com/vladikoff/netflix-1080p-firefox";
              description = "Forces 1080p playback for Netflix in Firefox. Based on vladikoff/netflix-1080p-firefox.";
              license = lib.licenses.mit;
              mozPermissions = [
                "storage"
                "webRequest"
                "webRequestBlocking"
                "*://assets.nflxext.com/*/ffe/player/html/*"
                "*://*.a.nflxso.net/sec/*/ffe/player/html/*"
                "*://netflix.com/*"
                "*://www.netflix.com/*"
              ];
              platforms = lib.platforms.all;
            };
          })
        ];

        settings = {
          "browser.sessionstore.max_resumed_crashes" = -1;
        };
      };
      stuff = {
        id = 1;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
        ];
      };
    };
  };

  # Autostart firefox
  xdg.configFile."autostart/firefox.desktop".source = "${config.programs.firefox.package}/share/applications/firefox.desktop";

  my.persistence.directories = [
    ".mozilla"
    ".cache/mozilla"
  ];
}
