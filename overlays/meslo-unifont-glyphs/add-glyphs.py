#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p "python3.withPackages (p: [ p.fonttools ])"
"""Copy glyphs that Meslo lacks from Unifont into Meslo TTFs, in place.

Usage: add-glyphs.py UNIFONT_OTF MESLO_TTF...

Unifont draws on a 16px-tall grid (64 units per em, 4 units per pixel), with
glyphs sitting on the baseline. Scaling by Meslo's em / Unifont's em keeps the
glyph the same size relative to the text as when a terminal falls back to
Unifont. The glyph is then centred horizontally in Meslo's cell.
"""

import sys

from fontTools.pens.reverseContourPen import ReverseContourPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen
from fontTools.ttLib import TTFont

# U+23F8 DOUBLE VERTICAL BAR (pause), used by nix-output-monitor.
CODEPOINTS = [0x23F8]


def main() -> None:
    unifont = TTFont(sys.argv[1])
    unifont_glyphs = unifont.getGlyphSet()
    unifont_cmap = unifont.getBestCmap()
    unifont_em = unifont["head"].unitsPerEm

    for path in sys.argv[2:]:
        font = TTFont(path)
        cmap = font.getBestCmap()
        scale = font["head"].unitsPerEm / unifont_em
        # Digits are tabular even in the proportional (Propo) variants.
        advance = font["hmtx"][cmap[ord("0")]][0]
        glyph_order = list(font.getGlyphOrder())

        for codepoint in CODEPOINTS:
            if codepoint in cmap:
                continue
            source = unifont_glyphs[unifont_cmap[codepoint]]

            # Measure the scaled outline to centre it in the cell.
            pen = TTGlyphPen(None)
            source.draw(TransformPen(pen, (scale, 0, 0, scale, 0, 0)))
            glyph = pen.glyph()
            glyph.recalcBounds(None)
            shift = (advance - (glyph.xMax - glyph.xMin)) / 2 - glyph.xMin

            # Unifont is CFF (counter-clockwise outlines); TrueType wants clockwise.
            pen = TTGlyphPen(None)
            source.draw(
                TransformPen(ReverseContourPen(pen), (scale, 0, 0, scale, round(shift), 0))
            )
            glyph = pen.glyph()
            glyph.recalcBounds(None)

            name = f"uni{codepoint:04X}"
            glyph_order.append(name)
            font["glyf"][name] = glyph
            font["hmtx"][name] = (advance, glyph.xMin)
            for table in font["cmap"].tables:
                if table.isUnicode():
                    table.cmap[codepoint] = name

        font.setGlyphOrder(glyph_order)
        # hdmx stores per-glyph device widths and would be missing the new glyph.
        if "hdmx" in font:
            del font["hdmx"]
        font.save(path)


if __name__ == "__main__":
    main()
