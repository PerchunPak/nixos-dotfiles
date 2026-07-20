{ ... }:
final: prev:
let
  t3code-unwrapped = prev.t3code.unwrapped.overrideAttrs (old: {
    patches = old.patches or [ ] ++ [
      ./add-codex-to-claude-models.patch
    ];
  });
in
{
  t3code = prev.t3code.override {
    inherit t3code-unwrapped;
    enableCodex = false;
  };
}
