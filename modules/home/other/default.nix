{ pkgs, nixosConfig, ... }:
{
  home.sessionVariables = {
    # Run Electron apps natively on Wayland
    # See https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    NIXOS_OZONE_WL = "1";
  };

  home.file = {
    ".config/qalculate/.keep".text = "";
    "Downloads/.keep".text = "";
  };

  gtk.enable = true;

  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    chromium.enable = true;
    obs-studio.enable = true;
    htop.enable = true;
    jq.enable = true;
    eza.enable = true;
  };

  my.persistence.directories = [
    ".config/hcloud"
  ];

  home.packages =
    with pkgs;
    [
      fd
      ncdu
      tor-browser
      meld
      gnumake
      dig
      mtr
      (mpv.override { youtubeSupport = false; })
      zip
      unzip
      bintools
      pavucontrol
      nixfmt
      wl-clipboard
      gleam
      erlang_27
      rebar3
      nixpkgs-review
      _7zz-rar
      rustc
      cargo
      wget
      gparted
      dbeaver-bin
      btdu # ncdu for btrfs
      cargo-expand
      tabiew
      libnotify
      hcloud
      cosmic-files
      tmux
      hyprshutdown
    ]
    ++ (lib.lists.optional nixosConfig.my.flatpak.enable pkgs.flatpak);
}
