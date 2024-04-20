# default configuration for mypy
{
  # from https://github.com/PerchunPak/python-template/blob/master/%7B%7B%20cookiecutter.project_name%20%7D%7D/setup.cfg
  xdg.configFile."mypy/config".text = ''
    [mypy]
    python_version = 3.12
    allow_redefinition = True
    check_untyped_defs = True
    disallow_any_explicit = True
    disallow_any_generics = True
    disallow_untyped_calls = True
    ignore_errors = False
    ignore_missing_imports = True
    implicit_reexport = False
    local_partial_types = True
    strict_optional = True
    strict_equality = True
    show_error_codes = True
    no_implicit_optional = True
    warn_no_return = True
    warn_unused_ignores = True
    warn_redundant_casts = True
    warn_unused_configs = True
    warn_unreachable = True
    warn_return_any = True
    exclude = venv
  '';
}
