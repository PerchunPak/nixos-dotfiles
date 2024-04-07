{
  pkgs,
  lib,
  config,
  ...
}: {
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
          (
            buildFirefoxXpiAddon
            {
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
            }
          )
        ];
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

  # uBlock Origin settings
  # see https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin:-configuration
  home.file.".mozilla/managed-storage/uBlock0@raymondhill.net.json".text = builtins.toJSON {
    name = "uBlock0@raymondhill.net";
    description = "My settings for uBlock Origin";
    type = "storage";
    data = {
      userSettings = [
        ["popupPanelSections" 15]
      ];
      toOverwrite = {
        filters = ["vk.com"];
        filterLists = [
          "user-filters"
          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-quick-fixes"
          "ublock-unbreak"
          "adguard-generic"
          "adguard-mobile"
          "easylist"
          "adguard-spyware"
          "adguard-spyware-url"
          "easyprivacy"
          "urlhaus-1"
          "curben-phishing"
          "dpollock-0"
          "plowe-0"
          "adguard-mobile-app-banners"
          "adguard-other-annoyances"
          "adguard-popup-overlays"
          "adguard-social"
          "adguard-widgets"
          "adguard-cookies"
          "ublock-cookies-adguard"
          "easylist-newsletters"
          "easylist-notifications"
          "easylist-annoyances"
          "fanboy-social"
          "fanboy-cookiemonster"
          "ublock-cookies-easylist"
          "ublock-annoyances"
          "CZE-0"
          "RUS-0"
        ];
        trustedSiteDirectives = [
          "# about-scheme"
          "chrome-extension-scheme"
          "chrome-scheme"
          "edge-scheme"
          "moz-extension-scheme"
          "opera-scheme"
          "perchun.it"
          "vivaldi-scheme"
          "wyciwyg-scheme"
        ];
      };
    };
  };

  # Autostart firefox
  xdg.configFile."autostart/firefox.desktop".source = "${config.programs.firefox.package}/share/applications/firefox.desktop";
}
