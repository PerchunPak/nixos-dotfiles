{ inputs, ... }:
final: prev: {
  ghcherry = prev.gh-cherry-pick.overridePythonAttrs (old: {
    src = inputs.ghcherry;

    pythonImportsCheck = [ "ghcherry" ];
  });
}
