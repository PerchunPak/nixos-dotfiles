{
  lib,
  system,
  my,
  config,
  astal,
  bluez,
  bluez-tools,
  btop,
  dart-sass,
  fetchFromGitHub,
  gpu-screen-recorder,
  gpustat,
  hyprpicker,
  libgtop,
  libnotify,
  networkmanager,
  python3Packages,
  wireplumber,
  wl-clipboard,
  writeShellScript,

  enableCuda ? config.cudaSupport,
}:
my.ags_2.bundle {
  pname = "hyprpanel";
  version = "unstable-2025-01-16";

  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "Jas-SinghFSU";
    repo = "HyprPanel";
    rev = "88609f7e4c244326face34cb992a79053f2c7810";
    hash = "sha256-YAT1VozLQ29V56EvEzJQswBOCLZDqn/gTU05mf+UFts=";
  };

  patches = [
    ./app-icons-and-workspace-numbers.patch
    ./lang-flags-instead-of-names.patch
  ];

  # keep in sync with https://github.com/Jas-SinghFSU/HyprPanel/blob/master/flake.nix#L28
  dependencies =
    [
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
      btop
      dart-sass
      hyprpicker
      libgtop
      libnotify
      networkmanager
      python3Packages.dbus-python
      python3Packages.gpustat
      wireplumber
      wl-clipboard
    ]
    ++ (lib.optionals (system == "x86_64-linux") [ gpu-screen-recorder ])
    ++ lib.optional enableCuda gpustat;

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
