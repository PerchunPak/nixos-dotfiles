{ ... }:
final: prev: {
  # The ASRock Polychrome USB driver OR-ed the board's hardware RGSwap bit
  # with the per-header "RGSwap" setting. The firmware turns that bit on for
  # ARGB headers, so the setting could not be turned off, and Direct mode
  # (used by the effects plugin) showed red as green and green as red.
  # With this patch only the setting in OpenRGB.json decides.
  openrgb = prev.openrgb.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./asrock-polychrome-rgswap.patch ];
  });
}
