require('lze').register_handlers(require('lzextras').lsp)

require 'my.options'
require 'my.keymaps'

require('lze').load {
  { import = 'my.plugins' },
  { import = 'my.LSPs' },
}
