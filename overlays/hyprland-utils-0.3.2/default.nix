{ ... }:
final: prev: {
  hyprutils = prev.hyprutils.overrideAttrs (old: {
    version = "0.3.2";

    src = old.src.override {
      hash = "sha256-7D5j2sh3Miw2CRdmx8ftepb342pl36kDFJy+3aVfDVc=";
    };
  });
}
