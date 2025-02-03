{ pkgs, nixosConfig, ... }:
{
  home.sessionVariables = {
    # Run Electron apps natively on Wayland
    # See https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    NIXOS_OZONE_WL = "1";
  };

  gtk.enable = true;

  programs = {
    ripgrep.enable = true;
    bat.enable = true;
    chromium.enable = true;
    obs-studio.enable = true;
    htop.enable = true;
    jq.enable = true;
    btop.enable = true;
  };

  home.packages =
    with pkgs;
    [
      fd
      eza
      ncdu
      tor-browser
      gnome-pomodoro
      meld
      zoom-us
      gnumake
      dig
      gnome-clocks
      mtr
      mpv
      onefetch
      zip
      unzip
      hexyl
      bintools
      pavucontrol
      baobab # gnome disk usage analyzer
      nixfmt-rfc-style
      wl-clipboard
      gleam
      erlang_27
      rebar3
      nixpkgs-review
      _7zz-rar
      rustc
      cargo
      watchman
    ]
    ++ (lib.lists.optional nixosConfig.my.flatpak.enable pkgs.flatpak);
}
