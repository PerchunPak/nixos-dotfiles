require('lze').register_handlers(require('lzextras').lsp)

require 'my.options'

require('lze').load {
  { import = 'my.plugins' },
  { import = 'my.LSPs' },
}
