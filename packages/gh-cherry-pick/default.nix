{
  inputs,
  python3Packages,
}:
python3Packages.buildPythonApplication (finalAttrs: {
  name = "gh-cherry-pick";
  version = "1.1.0";

  src = inputs.gh-cherry-pick;

  pyproject = true;
  build-system = with python3Packages; [
    hatchling
    uv-dynamic-versioning
  ];

  pythonRelaxDeps = [
    "attrs"
    "trio"
  ];

  dependencies = with python3Packages; [
    attrs
    cyclopts
    httpx
    loguru
    trio
    typing-extensions
  ];

  checkInputs = with python3Packages; [
    pytest
    pytest-cov-stub
    pytest-mock
    pytest-trio
  ];
})
