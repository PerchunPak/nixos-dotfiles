{ inputs, ... }:
final: prev: {
  gh-cherry-pick = prev.gh-cherry-pick.overridePythonAttrs (old: {
    src = inputs.gh-cherry-pick;

    nativeCheckInputs =
      with final.python3Packages;
      old.nativeCheckInputs
      ++ [
        faker
        pytest-asyncio
        pytest-httpx
      ];
  });
}
