---@diagnostic disable: undefined-global
local signs = require 'signs'

vim.pack.add({'https://github.com/nvim-tree/nvim-tree.lua'})

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

vim.keymap.set('n', '<leader>oo', '<cmd>NvimTreeToggle<cr>', { desc='Toggle Nvim Tree'})
vim.keymap.set('n', '<leader>of', '<cmd>NvimTreeFindFile!<cr>', { desc='Show the current file in Nvim Tree'})
