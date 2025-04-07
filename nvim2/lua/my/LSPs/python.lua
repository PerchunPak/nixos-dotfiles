return {
  {
    'pylsp',
    lsp = {
      cmd = { vim.g.python3_host_prog, '-m', 'pylsp' },
      settings = {
        pylsp = {
          plugins = {
            flake8 = { enabled = false },
            pydocstyle = { enabled = false },
            jedi_completion = {
              fuzzy = true,
              eager = true,
            },
            ruff = {
              enabled = true,
              -- copied from https://github.com/py-mine/mcstatus/blob/master/pyproject.toml
              select = {
                'F', -- Pyflakes
                'W', -- Pycodestyle (warnings)
                'E', -- Pycodestyle (errors)
                'N', -- pep8-naming
                'ANN', -- flake8-annotations
                'B', -- flake8-bugbear
                'FA', -- flake8-future-annotations
                'TID', -- flake8-tidy-imports
                'UP007', -- flake8-new-union-types equivalent rule
                'RUF', -- ruff's custom rules
              },
              ignore = {
                'ANN002', -- Missing type annotation for *args
                'ANN003', -- Missing type annotation for **kwargs
                'ANN101', -- Missing type annotation for self in method
                'ANN102', -- Missing type annotation for cls in classmethod
                'ANN204', -- Missing return type annotation for special method
                'B904', -- Exception raised within try-except should use raise ... from exc
                'RUF012', -- Mutable class attributes should be annotated with `typing.ClassVar`

                -- Redundant rules with ruff-format:
                'E111', -- Indentation of a non-multiple of 4 spaces
                'E114', -- Comment with indentation  of a non-multiple of 4 spaces
                'E117', -- Checks for over-indented code
                'D206', -- Checks for docstrings indented with tabs
                'D300', -- Checks for docstring that use ''' instead of """
                'Q000', -- Checks of inline strings that use wrong quotes (' instead of ")
                'Q001', -- Multiline string that use wrong quotes (''' instead of """)
                'Q002', -- Checks for docstrings that use wrong quotes (''' instead of """)
                'Q003', -- Checks for avoidable escaped quotes ("\"" -> '"')
                'COM812', -- Missing trailing comma (in multi-line lists/tuples/...)
                'COM819', -- Prohibited trailing comma (in single-line lists/tuples/...)
                'ISC001', -- Single line implicit string concatenation ("hi" "hey" -> "hihey")
                'ISC002', -- Multi line implicit string concatenation
              },
              targetVersion = 'py312',
            },
          },
        },
      },
    },
  },
  {
    'basedpyright',
    lsp = {
      settings = {
        basedpyright = {
          analysis = {
            diagnosticMode = 'workspace',
          },
        },
      },
    },
  },
}
