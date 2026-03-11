return {
  {
    'ruff',
    lsp = {
      settings = {
        lint = {
          -- copied from https://github.com/py-mine/mcstatus/blob/master/pyproject.toml
          select = { 'ALL' },
          unfixable = { 'F401' }, -- unused import
          ignore = {
            'A', -- Shadowing builtins
            'EM', -- Very weird rules for using exceptions
            'FIX', -- Line contains TODO, consider resolving the issue
            'COM812', -- Missing trailing comma (in multiline lists/tuples/...)
            'D203', -- Blank line required before class docstring
            'D213', -- Multi-line docstring summary should start at the second line
            'PLR2004', -- Magic value used in comparison
            'RET504', -- Unnecessary assignment to a variable before `return` statement
            'S101', -- Use of `assert` detected
            'S311', -- Standard pseudo-random generators are not suitable for cryptographic purposes
            'TD002', -- Missing author in TODO
            'TD003', -- Missing issue link for this TODO
            'TRY003', -- Avoid specifying long messages outside the exception class
            'ISC002', -- Multi line implicit string concatenation
            'ISC003', -- Multi line explicit string concatenation

            'D100', -- Missing docstring in public module
            'D101', -- Missing docstring in public class
            'D102', -- Missing docstring in public method
            'D103', -- Missing docstring in public function
            'D104', -- Missing docstring in public package
            'D105', -- Missing docstring in magic method
            'D106', -- Missing docstring in public nested class
            'D107', -- Missing docstring in __init__
            'D413', -- Missing blank line after last section
          },

          isort = {
            ['order-by-type'] = false,
            ['case-sensitive'] = true,
            ['combine-as-imports'] = true,
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
            diagnosticSeverityOverrides = {
              reportAny = 'none',
              reportImplicitStringConcatenation = 'none',
            },
          },
        },
      },
    },
  },
}
