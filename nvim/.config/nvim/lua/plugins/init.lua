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

local plugins = {
  require 'plugins/cmp-buffer',
  require 'plugins/cmp-cmdline',
  require 'plugins/cmp-luasnip',
  require 'plugins/cmp-nvim-lsp',
  require 'plugins/cmp-path',
  require 'plugins/codecompanion',
  require 'plugins/fzf',
  require 'plugins/lspkind-nvim',
  require 'plugins/lualine',
  require 'plugins/luasnip',
  require 'plugins/mason',
  require 'plugins/mason-lspconfig',
  require 'plugins/minidiff',
  require 'plugins/mini-pairs',
  require 'plugins/neogit',
  require 'plugins/neorg',
  require 'plugins/neotest',
  require 'plugins/nvim-cmp',
  require 'plugins/nvim-tree',
  require 'plugins/nvim-treesitter',
  require 'plugins/nvim-web-devicons',
  require 'plugins/onenord',
  require 'plugins/plenary',
  require 'plugins/telescope',
  require 'plugins/trouble',
  require 'plugins/ts-comment',
  require 'plugins/vim-surround',
  require 'plugins/vim-tmux-navigator',
  require 'plugins/which-key',
}

require("lazy").setup(plugins, {})
