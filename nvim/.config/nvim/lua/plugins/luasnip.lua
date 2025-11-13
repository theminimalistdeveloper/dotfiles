---@diagnostic disable: undefined-global

return {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      local fromVSCode = require('luasnip.loaders.from_vscode')
      fromVSCode.lazy_load()
      fromVSCode.lazy_load({
        paths = { vim.fn.expand('./snippets') }
      })
    end,
    keys = {
      {
        '<C-Tab>',
        function()
          return require('luasnip').jump(1)
        end,
        silent = true,
        mode = 'i',
      },
      {
        '<C-S-Tab>',
        function()
          require('luasnip').jump(-1)
        end,
        mode = 's',
        silent = true,
      },
    },
  }
