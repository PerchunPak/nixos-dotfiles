{ ... }:
_: prev: {
  codex = prev.codex.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./model-identity.patch ];
  });
}
