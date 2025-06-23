{
  config,
  inputs,
  lib,

  ags,
  astal,
  bluez,
  bluez-tools,
  brightnessctl,
  btop,
  dart-sass,
  glib,
  glib-networking,
  gnome-bluetooth,
  gpu-screen-recorder,
  gpustat,
  grimblast,
  gtksourceview3,
  gvfs,
  hyprpicker,
  libgtop,
  libnotify,
  libsoup_3,
  matugen,
  networkmanager,
  nix-update-script,
  python3,
  pywal,
  stdenv,
  swww,
  upower,
  wireplumber,
  wl-clipboard,
  writeShellScript,

  enableCuda ? config.cudaSupport,
}:
ags.bundle {
  pname = "hyprpanel";
  version = "unstable-${inputs.hyprpanel.lastModifiedDate}";

  __structuredAttrs = true;
  strictDeps = true;

  src = inputs.hyprpanel;

  patches = [
    ./app-icons-and-workspace-numbers.patch
    ./lang-flags-instead-of-names.patch
  ];

  # keep in sync with https://github.com/Jas-SinghFSU/HyprPanel/blob/master/flake.nix#L42
  dependencies = [
    astal.apps
    astal.battery
    astal.bluetooth
    astal.cava
    astal.hyprland
    astal.mpris
    astal.network
    astal.notifd
    astal.powerprofiles
    astal.tray
    astal.wireplumber

    bluez
    bluez-tools
    brightnessctl
    btop
    dart-sass
    glib
    gnome-bluetooth
    grimblast
    gtksourceview3
    gvfs
    hyprpicker
    libgtop
    libnotify
    libsoup_3
    matugen
    networkmanager
    pywal
    swww
    upower
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
  ] ++ (lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [ gpu-screen-recorder ]);

  passthru.updateScript = nix-update-script { extraArgs = [ "--version=branch" ]; };

  postFixup =
    let
      script = writeShellScript "hyprpanel" ''
        export GIO_EXTRA_MODULES='${glib-networking}/lib/gio/modules'
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
