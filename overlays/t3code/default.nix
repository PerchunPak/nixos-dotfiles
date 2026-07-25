{ ... }:
final: prev:
let
  t3code-unwrapped = (prev.t3code.unwrapped.override { pnpm_10 = final.pnpm_11; }).overrideAttrs (
    finalAttrs: oldAttrs: {
      version = "0.0.28-unstable-2026-07-25";

      src = final.fetchFromGitHub {
        owner = "pingdotgg";
        repo = "t3code";
        rev = "38cfc25e5422e468303f2010f639cf3de9ad89ba";
        hash = "sha256-8ligJUNcd30G71621dfMQ4R6cJM+rbGKIa7w7LXdfW0=";
      };

      pnpmDeps = final.fetchPnpmDeps {
        pnpm = final.pnpm_11;
        inherit (finalAttrs)
          pname
          version
          src
          pnpmWorkspaces
          ;
        fetcherVersion = 4;
        hash = "sha256-QNVBRvXVUOKZEdIqKY2dfjvmivMTaJJSh2cexvtdJ6k=";
      };

      preBuild = ''
        export pnpm_config_verify_deps_before_run=false
      ''
      + oldAttrs.preBuild;
    }
  );
in
{
  t3code = prev.t3code.override { inherit t3code-unwrapped; };
}
