{lib, ...}: {
  mkEnableByDefaultOption = name:
    (lib.mkEnableOption name)
    // {
      default = true;
      example = false;
    };
}
