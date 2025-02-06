{
  lib,
  system,
  my,
  config,
  astal,
  bluez,
  bluez-tools,
  brightnessctl,
  btop,
  dart-sass,
  fetchFromGitHub,
  glib,
  gnome-bluetooth,
  gpu-screen-recorder,
  gpustat,
  grimblast,
  gvfs,
  hyprpicker,
  libgtop,
  libnotify,
  matugen,
  networkmanager,
  python3,
  python3Packages,
  pywal,
  swww,
  upower,
  wireplumber,
  wl-clipboard,
  writeShellScript,

  enableCuda ? config.cudaSupport,
}:
my.ags_2.bundle {
  pname = "hyprpanel";
  version = "unstable-2025-01-25";

  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "Jas-SinghFSU";
    repo = "HyprPanel";
    rev = "74065af3d2aa576e8b183d720033c3eece3deb70";
    hash = "sha256-sVy0QU4fpZsUWj5B8t6jUNZHzVLC22+HYqcFG9pKPik=";
  };

  patches = [
    ./app-icons-and-workspace-numbers.patch
    ./lang-flags-instead-of-names.patch
  ];

  # keep in sync with https://github.com/Jas-SinghFSU/HyprPanel/blob/master/flake.nix#L28
  dependencies = [
    astal.apps
    astal.battery
    astal.bluetooth
    my.astal-cava # doesn't compile without it
    astal.hyprland
    astal.mpris
    astal.network
    astal.notifd
    astal.powerprofiles
    my.astal-tray
    astal.wireplumber

    bluez
    bluez-tools
    brightnessctl
    btop
    dart-sass
    glib
    gnome-bluetooth
    grimblast
    gvfs
    hyprpicker
    hyprpicker
    libgtop
    libnotify
    matugen
    networkmanager
    networkmanager
    python3Packages.dbus-python
    python3Packages.gpustat
    pywal
    swww
    upower
    wireplumber
    wireplumber
    wl-clipboard
    (python3.withPackages (
      ps:
      with ps;
      [
        dbus-python
        pygobject3
      ]
      ++ lib.optional enableCuda gpustat
    ))
  ] ++ (lib.optionals (system == "x86_64-linux") [ gpu-screen-recorder ]);

  # NOTE: no update script as dependencies must be kept in sync with upstream
  # and it is problematic to do it in an update script. I don't have push
  # access to r-ryantm's repo, so I will just do updates manually

  postFixup =
    let
      script = writeShellScript "hyprpanel" ''
        if [ "$#" -eq 0 ]; then
          exec @out@/bin/.hyprpanel
        else
          exec ${astal.io}/bin/astal -i hyprpanel "$*"
        fi
      '';
    in
    # bash
    ''
      mv "$out/bin/hyprpanel" "$out/bin/.hyprpanel"
      cp '${script}' "$out/bin/hyprpanel"
      substituteInPlace "$out/bin/hyprpanel" \
        --replace-fail '@out@' "$out"
    '';

  meta = {
    description = "Bar/Panel for Hyprland with extensive customizability";
    homepage = "https://github.com/Jas-SinghFSU/HyprPanel";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ perchun ];
    mainProgram = "hyprpanel";
    platforms = lib.platforms.linux;
  };
}
