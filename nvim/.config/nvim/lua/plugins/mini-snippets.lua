vim.pack.add({
  'https://github.com/nvim-mini/mini.snippets',
  'https://github.com/rafamadriz/friendly-snippets'
})
local miniSnippets = require('mini.snippets')
miniSnippets.setup({
  snippets = {
    miniSnippets.gen_loader.from_lang(),
  },
})
