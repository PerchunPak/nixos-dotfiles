{
  lib,
  astal,
  blueprint-compiler,
  buildGoModule,
  callPackage,
  dart-sass,
  fetchFromGitHub,
  gjs,
  glib,
  gobject-introspection,
  gtk4-layer-shell,
  installShellFiles,
  nix-update-script,
  nodejs,
  stdenv,
  wrapGAppsHook3,
  writers,

  extraPackages ? [ ],
}:
let
  datadirs =
    writers.writeNu "datadirs"
      # nu
      ''
        $env.XDG_DATA_DIRS
        | split row ":"
        | filter { $"($in)/gir-1.0" | path exists }
        | str join ":"
      '';

  bins = [
    gjs
    nodejs
    dart-sass
    blueprint-compiler
    astal.io
  ];
in
buildGoModule rec {
  pname = "ags";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "Aylur";
    repo = "ags";
    tag = "v${version}";
    hash = "sha256-snHhAgcH8hACWZFaAqHr5uXH412UrAuA603OK02MxN8=";
  };

  vendorHash = "sha256-Pw6UNT5YkDVz4HcH7b5LfOg+K3ohrBGPGB9wYGAQ9F4=";
  proxyVendor = true;

  ldflags = [
    "-s"
    "-w"
    "-X main.astalGjs=${astal.gjs}/share/astal/gjs"
    "-X main.gtk4LayerShell=${gtk4-layer-shell}/lib/libgtk4-layer-shell.so"
  ];

  nativeBuildInputs = [
    wrapGAppsHook3
    gobject-introspection
    installShellFiles
  ];

  buildInputs = extraPackages ++ [
    glib
    astal.io
    astal.astal3
    astal.astal4
  ];

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix NIX_GI_DIRS : "$(${datadirs})"
      --prefix PATH : "${lib.makeBinPath (bins ++ extraPackages)}"
    )
  '';

  postInstall =
    lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform)
      # bash
      ''
        installShellCompletion \
          --cmd ags \
          --bash <($out/bin/ags completion bash) \
          --fish <($out/bin/ags completion fish) \
          --zsh <($out/bin/ags completion zsh)
      '';

  passthru = {
    bundle = callPackage ./bundle.nix { };
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Scaffolding CLI for Astal+TypeScript";
    homepage = "https://github.com/Aylur/ags";
    changelog = "https://github.com/Aylur/ags/releases/tag/v${version}";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [
      foo-dogsquared
      johnrtitor
      perchun
    ];
    mainProgram = "ags";
    platforms = lib.platforms.linux;
  };
}