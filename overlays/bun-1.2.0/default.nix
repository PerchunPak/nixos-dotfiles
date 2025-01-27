{ ... }:
final: prev: {
  bun = prev.bun.overrideAttrs (old: {
    version = "1.2.0";
    src = final.fetchurl {
      url = "https://github.com/oven-sh/bun/releases/download/bun-v1.2.0/bun-linux-x64.zip";
      hash = "sha256-B0fpcBILE6HaU0G3UaXwrxd4vYr9cLXEWPr/+VzppFM=";
    };
  });
}
