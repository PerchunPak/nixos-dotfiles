{ ... }:
final: prev: {
  nur = prev.nur // {
    repos = prev.nur.repos // {
      rycee = prev.nur.repos.rycee // {
        firefox-addons = prev.nur.repos.rycee.firefox-addons // {
          enhancer-for-youtube = prev.nur.repos.rycee.firefox-addons.enhancer-for-youtube.override {
            url = "https://addons.mozilla.org/firefox/downloads/file/4354445/enhancer_for_youtube-2.0.126.1.xpi";
            sha256 = "281035bd4211a8fbdcafb85e98044e3c02550495f91e1d00680cde404c742fbf";
          };
        };
      };
    };
  };
}
