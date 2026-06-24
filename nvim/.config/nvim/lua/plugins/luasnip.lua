return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  config = function()
    require('luasnip').setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    -- Load VSCode-style snippets (friendly-snippets) lazily
    require("luasnip.loaders.from_vscode").lazy_load()
  end
}
