{
  lib,
  pkgs,
  nixosConfig,
  ...
}:
{
  home.sessionVariables = {
    # Run Electron apps natively on Wayland
    # See https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    NIXOS_OZONE_WL = "1";
  };

  home.file = {
    ".config/tombi/config.toml".text =
      # toml
      ''
        [lint.rules]
        tables-out-of-order = "off"
      '';
    ".config/qalculate/.keep".text = "";
    "Downloads/.keep".text = "";
  };

  gtk.enable = nixosConfig.my.gui.enable;
  gtk.gtk4.theme = lib.mkDefault null;

  programs = {
    bat.enable = true;
    chromium.enable = nixosConfig.my.gui.enable;
    eza.enable = true;
    htop.enable = true;
    jq.enable = true;
    obs-studio.enable = nixosConfig.my.gui.enable;
    ripgrep.enable = true;
  };

  home.packages =
    with pkgs;
    lib.mkMerge [
      [
        (_7zz.override {
          useUasm = false;
          enableUnfree = true; # enable .rar
        })
        ansifilter
        bintools
        brightnessctl
        btdu # ncdu for btrfs
        cargo
        cargo-expand
        dig
        fd
        ghcherry
        gnumake
        libnotify
        lsof
        meld
        ncdu
        nix-diff-rs
        nixfmt
        nixpkgs-review
        rustc
        tabiew
        unzip
        wget
        xxd
        zip
      ]
      (lib.mkIf (nixosConfig.my.flatpak.enable) [ flatpak ])
      (lib.mkIf nixosConfig.my.gui.enable [
        (mpv.override { youtubeSupport = false; })
        actual-client
        cosmic-files
        dbeaver-bin
        hyprshutdown
        kdePackages.kate
        pavucontrol
        signal-desktop
        tor-browser
        wl-clipboard
      ])
    ];
}
