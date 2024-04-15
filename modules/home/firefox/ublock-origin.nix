{
  # uBlock Origin settings
  # see https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin%3A-configuration
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
}
