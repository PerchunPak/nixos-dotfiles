{
  config,
  inputs,
  lib,
  my,
  system,

  ags,
  astal,
  bluez,
  bluez-tools,
  brightnessctl,
  btop,
  dart-sass,
  glib,
  gnome-bluetooth,
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
  wf-recorder,
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

  # keep in sync with https://github.com/Jas-SinghFSU/HyprPanel/blob/master/flake.nix#L28
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
    wf-recorder
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
  ];

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
