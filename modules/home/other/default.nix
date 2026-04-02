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

  gtk.enable = true;
  gtk.gtk4.theme = lib.mkDefault null;

  programs = {
    bat.enable = true;
    chromium.enable = true;
    claude-code.enable = true;
    eza.enable = true;
    htop.enable = true;
    jq.enable = true;
    obs-studio.enable = true;
    ripgrep.enable = true;
  };

  home.packages =
    with pkgs;
    [
      (_7zz-rar.override { useUasm = false; })
      (mpv.override { youtubeSupport = false; })
      ansifilter
      bintools
      brightnessctl
      btdu # ncdu for btrfs
      cargo
      cargo-expand
      cosmic-files
      dbeaver-bin
      dig
      erlang_27
      fd
      gleam
      gnumake
      gparted
      hyprshutdown
      libnotify
      meld
      mtr
      ncdu
      nixfmt
      nixpkgs-review
      pavucontrol
      rebar3
      rustc
      signal-desktop
      tabiew
      tmux
      tor-browser
      unzip
      wget
      wl-clipboard
      xxd
      zip
    ]
    ++ (lib.lists.optional nixosConfig.my.flatpak.enable pkgs.flatpak);
}
