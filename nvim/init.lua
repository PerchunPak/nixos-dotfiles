require('lze').register_handlers(require('lzextras').lsp)

require 'my.options'
require 'my.keymaps'
require 'my.restore-cursor-position'

require('lze').load {
  { import = 'my.plugins' },
  { import = 'my.LSPs' },
}
