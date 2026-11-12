{ inputs, lib, ... }:
let
  collect = input: [ input.outPath ] ++ lib.concatMap collect (lib.attrValues (input.inputs or { }));
in
{
  # Root every (transitive) flake input. Without this, GC deletes inputs like
  # flake-utils-plus, and then every evaluation spends ~2s per missing input
  # querying substituters for its source.
  system.extraDependencies = lib.unique (
    lib.concatMap collect (lib.attrValues (removeAttrs inputs [ "self" ]))
  );
}
