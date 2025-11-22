---@diagnostic disable: undefined-global

local signs = require 'signs'

return {
  'nvim-tree/nvim-tree.lua',
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("nvim-tree").setup({
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = signs.Hint,
          info = signs.Info,
          warning = signs.Warn,
          error = signs.Error,
        },
      },
      view = {
        relativenumber = true,
        width = 40
      },
      filters = { dotfiles = false }
    })
  end,
  keys = {
    { '<leader>oo', '<cmd>NvimTreeToggle<cr>', mode = 'n' },
    { '<leader>of', '<cmd>NvimTreeFindFile!<cr>', mode = 'n' },
  },
}
