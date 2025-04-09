------------------------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------------------------

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
  -- AI
  'github/copilot.vim',
  -- LSP
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require "nvim-treesitter.install".compilers = { "gcc" }
    end,
  },
  'nvim-treesitter/nvim-treesitter-context',
  'williamboman/mason-lspconfig.nvim',
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup {}
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        filters = { dotfiles = true }
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  -- Icons for the autocomplete list
  'onsails/lspkind-nvim',
  -- COMPLETION
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end
        },
        experimental = { ghost_text = { hl_group = 'LineNr' } },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = sources,
        formatting = {
          format = lspkind.cmp_format({
            mode      = 'symbol_text',
            max_width = 70,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ['<S-j>'] = cmp.mapping.select_next_item({ select = true }),
          ['<S-k>'] = cmp.mapping.select_prev_item({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      })

      -- when searching auto complete with words present in the buffers
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })

      -- when executing a command auto complete with commands and paths
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, config = function() require('ibl').setup() end },
  -- SNIPPETS
  { 'saadparwaiz1/cmp_luasnip' },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local fromVSCode = require("luasnip.loaders.from_vscode")
      fromVSCode.lazy_load()
      fromVSCode.lazy_load({
        paths = { vim.fn.expand("./snippets") }
      })
    end
  },

  -- FUZZY FINDER
  -- Helper functions in lua
  'nvim-lua/plenary.nvim',
  -- Fuzzy finder engine
  { 'junegunn/fzf' },
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require ('telescope').setup({
        defaults = {},
        pickers = {
          find_files = {
            hidden = true,
            previewer = false,
            theme = 'ivy',
          },
          live_grep = {
            theme = 'ivy',
            previewer = false,
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons' }
  },
  -- MISC
  -- Helper for surrounds around text objects
  'tpope/vim-surround',
  'cohama/lexima.vim',
  -- Git helper
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = true
  },
  { "f-person/git-blame.nvim" },
  -- Information statusline
  'hoob3rt/lualine.nvim',
  -- Helper for commenting, works with multiple languages
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  -- Shows list of available commands
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  -- Helper to run specific tests and test files
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-jest',
      'rouge8/neotest-rust',
    },
    config = function()
      require('neotest').setup({})
    end
  },
  -- HTML / CSS dynamic snippet generator
  'mattn/emmet-vim',
  -- Themes
  { "catppuccin/nvim", as = "catppuccin-macchiato" },
  -- Enable navigation between nvim and tmux windows using <c-(h,j,k,l)>
  'christoomey/vim-tmux-navigator',
  -- RUST - Cargo dependency helper
  'Saecki/crates.nvim',
  -- CSS
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup()
    end,
  }
}

require("lazy").setup(plugins, {})
