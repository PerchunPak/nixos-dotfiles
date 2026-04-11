{ inputs, ... }:
final: prev: {
  gh-cherry-pick = prev.gh-cherry-pick.overrideAttrs {
    src = inputs.gh-cherry-pick;
  };
  wayle = prev.wayle.overrideAttrs {
    src = inputs.wayle;
  };
}
