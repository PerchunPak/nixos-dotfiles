{ inputs, ... }:
final: prev: {
  ghcherry = prev.ghcherry.overridePythonAttrs (old: {
    src = inputs.ghcherry;
  });
}
