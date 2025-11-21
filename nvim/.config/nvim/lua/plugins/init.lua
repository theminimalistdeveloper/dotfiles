------------------------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------------------------
---@diagnostic disable: undefined-global

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require 'plugins/codecompanion',
  require 'plugins/mason',
  require 'plugins/neogit',
  require 'plugins/nvim-tree',
  require 'plugins/mini',
  require 'plugins/nvim-treesitter',
  require 'plugins/onenord',
  require 'plugins/trouble',
  require 'plugins/vim-tmux-navigator',
}, {})
