{
  pkgs,
  inputs,
  ...
}:
let
  rycee-nur = import "${inputs.rycee-nur}" { inherit pkgs; };

  profile = {
    bookmarks = [
      {
        name = "NixOS repo";
        url = "https://github.com/NixOS/nixpkgs";
      }
    ];

    extensions = {
      force = true;
      packages = with rycee-nur.firefox-addons; [
        bitwarden
        darkreader
        disable-javascript
        enhancer-for-youtube
        grammarly
        languagetool
        refined-github
        sponsorblock
        stylus
        ublock-origin
      ];

      settings = {
        # refined github
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".settings = {
          welcomed = true;
        };
        "enhancerforyoutube@maximerf.addons.mozilla.org".settings = {
          controlbar = {
            active = false;
            autohide = false;
            centered = true;
            position = "absolute";
          };
          controls = [
            "speed-minus"
            "speed"
            "speed-plus"
          ];
          controlsvisible = true;
          speed = 2.4;
        };
        "uBlock0@raymondhill.net".settings = {
          selectedFilterLists = [
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
        };
      };
    };

    settings = {
      "extensions.webextensions.ExtensionStorageIDB.enabled" = false;
      "browser.download.lastDir" = "/home/perchun/Downloads";
      "browser.sessionstore.max_resumed_crashes" = -1;
    };

    search = {
      default = "Google";

      engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };
    };
  };
in
{
  programs.floorp = {
    enable = true;
    languagePacks = [
      "uk"
      "ru" # sorry
      "cs" # czech
    ];
    profiles = {
      perchun = profile;
      stuff = profile // {
        id = 1;
      };
    };
  };

  my.persistence.directories = [
    ".floorp"
    ".cache/floorp"
  ];
}
