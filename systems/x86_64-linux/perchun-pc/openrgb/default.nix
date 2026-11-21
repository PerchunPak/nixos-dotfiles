{ ... }:
{
  my.openrgb = {
    enable = true;
    profile = ./gta6.json;
    # Manually resized zones (ARGB header LED counts).
    configFile = ./Configuration.json;
    # See overlays/openrgb-asrock-rgswap.
    settings = {
      # Picks up the Logitech G305 mouse, which should not be managed by OpenRGB.
      Detectors.detectors."Logitech HID++ 2.0" = false;
      "ASRock Polychrome USB".RGSwap = {
        "Addressable Header 1" = false;
        "Addressable Header 2" = false;
        "Addressable Header 3/Audio" = false;
        "IO Cover" = true;
        "PCB" = true;
        "PCH" = true;
        "RGB LED 1 Header" = false;
        "RGB LED 2 Header" = false;
      };
    };
  };
}
