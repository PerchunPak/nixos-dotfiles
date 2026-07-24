{ ... }:
final: prev: {
  # https://github.com/NixOS/nixpkgs/issues/544083
  poetry = prev.poetry.overridePythonAttrs (
    old:
    assert old.version == "2.4.1";
    {
      disabledTests = old.disabledTests or [ ] ++ [
        "test_execute_executes_a_batch_of_operations"
        "test_execute_prints_warning_for_yanked_package"
      ];
    }
  );
}
