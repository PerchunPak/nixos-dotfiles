{ ... }:
final: prev: {
  typescript-language-server = prev.typescript-language-server.overrideAttrs (
    finalAttrs: old: {
      pnpmDeps =
        assert old.pnpmDeps.outputHash == "sha256-MUSxDMlbG21KSesGdEvqa2kEpuVfLlXRUX1qV/FGsSo=";
        final.fetchPnpmDeps {
          inherit (finalAttrs) pname version src;
          pnpm = final.pnpm_12;
          fetcherVersion = 4;
          hash = "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4=";
        };
    }
  );
}
