return {
  'nvim-mini/mini.snippets',
  opts = {},
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local miniSnippets = require('mini.snippets')
    miniSnippets.setup({
      snippets = {
        miniSnippets.gen_loader.from_lang(),
      },
    })
  end,
}
