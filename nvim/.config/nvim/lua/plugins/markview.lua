vim.pack.add({'https://github.com/OXY2DEV/markview.nvim'})

vim.treesitter.language.register('markdown', 'telekasten')
vim.treesitter.language.register('markdown', 'codecompanion')

require('markview').setup({
  preview = {
    icon_provider = 'internal',
    filetypes = { 'markdown', 'telekasten', 'codecompanion' },
    ignore_buftypes = {}
  }
})
