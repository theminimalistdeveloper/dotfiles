-------------------------------------------------------------------------------
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
  'neovim/nvim-lspconfig',
  -- Signature parameters and documentation
  'ray-x/lsp_signature.nvim',
  -- markdown preview
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install'
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
          ['<Tab>'] = cmp.mapping.select_next_item({ select = true }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ select = true }),
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
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      local telescope = require 'telescope'
      telescope.setup({
        defaults = {},
        extensions = {
          file_browser = {
            theme = 'ivy',
          },
          fzf = {
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = 'smart_case',
          }
        }
      })
      telescope.load_extension('file_browser')
      telescope.load_extension('fzf')
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", 'nvim-tree/nvim-web-devicons' }
  },
  -- use fzf in telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  -- MISC
  -- Helper for surrounds around text objects
  'tpope/vim-surround',
  -- Git helper
  'tpope/vim-fugitive',
  -- Gitsigns - Used only for showing blame per line on virtual text
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({ current_line_blame = true })
    end,
  },
  -- Information statusline
  'hoob3rt/lualine.nvim',
  -- Set the root directory to the folder of the current buffer. really useful
  {
    'airblade/vim-rooter',
    config = function()
      -- considers switches to the folder of the current buffer if it finds some of the files listed below
      vim.g.rooter_patterns = { '.git', 'package.json' }
    end,
  },
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
  'janko/vim-test',
  -- HTML / CSS dynamic snippet generator
  'mattn/emmet-vim',
  -- Themes
  { "catppuccin/nvim", as = "catppuccin" },
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
