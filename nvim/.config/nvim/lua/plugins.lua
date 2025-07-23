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
  -- Notes 
  {
    "nvim-neorg/neorg",
    ft = "norg",
    priority = 100, -- Ensure Neorg is loaded before other plugins that depend on it
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function ()
      require('neorg').setup {
        load = {
          ["core.defaults"] = {}, -- Load all the default modules
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode", -- Use the zen mode plugin for distraction-free writing
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                personal = "~/Notes/Personal",
                corporate = "~/Notes/Corporate",
              },
              default_workspace = "personal",
            },
          },
          ["core.concealer"] = {
            config = {
              conceal = true,
              conceal_level = 3
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
        },
      }
    end,
  },
  "folke/zen-mode.nvim",
  "nvim-neorg/neorg-telescope", -- Telescope integration for Neorg
  -- AI
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_filetypes = {
        javascript = true,
        typescript = true,
        typescriptreact = true,
        javascriptreact = true,
        python = true,
        lua = true,
        rust = false,
        markdown = false,
      }
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = {
              name="copilot",
              model= "gemini-2.5-pro",
            },
            keymaps= {
              modes = { n = { "<CR>" }, i = { "<CR>" } },
            },
          },
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" }
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  -- LSP
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "c",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "norg",
          "python",
          "rust",
          "typescript",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        auto_install = true,
        indent = { enable = true },
        incremental_selection = { enable = true },
      }
    end,
  },
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
        view = {
          relativenumber = true
        },
        filters = { dotfiles = false }
      })
    end,
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
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
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
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
  -- SNIPPETS
  -- Add luasnip as source for completion
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, config = function() require('ibl').setup() end },
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
            hidden = false,
            previewer = true,
            theme = 'ivy',
          },
          live_grep = {
            theme = 'ivy',
            previewer = true,
          },
        },
      })
    end,
  },
  -- MISC
  -- Helper for surrounds around text objects
  'tpope/vim-surround',
  -- auto close
  'cohama/lexima.vim',
  -- Git helper
  {
    "NeogitOrg/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    config = true
  },
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
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-jest',
      'rouge8/neotest-rust',
    },
    config = function()
      require('neotest').setup({})
    end
  },
  -- Themes
  { "catppuccin/nvim", as = "catppuccin-macchiato" , opt = {
    transparent = true
  }},
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
