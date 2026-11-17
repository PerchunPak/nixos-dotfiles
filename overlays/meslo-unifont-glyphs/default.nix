# Meslo lacks U+23F8 (pause, used by nix-output-monitor). Without it, zellij's
# terminal falls back to Noto Color Emoji and draws an orange emoji square.
# Copy the glyph from Unifont, which is what Alacritty falls back to.
{ ... }:
final: prev: {
  nerd-fonts = prev.nerd-fonts // {
    meslo-lg = prev.nerd-fonts.meslo-lg.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [
        (final.python3.withPackages (p: [ p.fonttools ]))
      ];
      postInstall = (old.postInstall or "") + ''
        python3 ${./add-glyphs.py} \
          ${final.unifont}/share/fonts/opentype/unifont/unifont.otf \
          $out/share/fonts/truetype/NerdFonts/MesloLG/*.ttf
      '';
    });
  };
}
