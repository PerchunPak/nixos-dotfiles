{ lib, ... }:
{
  mkEnableByDefaultOption =
    name:
    (lib.mkEnableOption name)
    // {
      default = true;
      example = false;
    };

  toSecretFile = name: ../../secrets/${name}.age;
}
