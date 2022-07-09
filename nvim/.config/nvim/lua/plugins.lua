-------------------------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------------------------

-- Load the package manager
vim.cmd [[packadd packer.nvim]]

-- PLUGINS LIST
-------------------------------------------------------------------------------

require('packer').startup(function()
  -- Plugin manager
  use { 'wbthomason/packer.nvim', opt = true }

  -- LSP
  -- Automatically creates missing LSP diagnostics highlight groups for color
  -- schemes that don't yet support the Neovim 0.5 builtin lsp client.
  use 'folke/lsp-colors.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'
  -- Signature parameters and documentation
  use 'ray-x/lsp_signature.nvim'
  -- Icons for the autocomplete list
  use 'onsails/lspkind-nvim'

  -- COMPLETION
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- FILE NAVIGATOR
  -- Tree view filesystem navigator
  use 'kyazdani42/nvim-tree.lua'
  -- Adds icons to the file navigator items
  use 'kyazdani42/nvim-web-devicons'

  -- SNIPPETS
  -- Ultisnips - the snippet engine used everywhere
  use 'sirver/ultisnips'
  -- Initial package of snippets for multiple languages
  use 'honza/vim-snippets'
  -- Jest snippets
  use 'jhkersul/vim-jest-snippets'
  -- Necessary to show Ultisnips in the CMP suggestion window
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- FUZZY FINDER
  -- Helper to draw nice popups
  use 'nvim-lua/popup.nvim'
  -- Helper functions in lua
  use 'nvim-lua/plenary.nvim'
  -- Fuzzy finder engine
  use 'nvim-telescope/telescope.nvim'
  -- use fzf in telescope
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- MISC
  -- Tabnine, AI assistant
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }
  -- Helper for surrounds around text objects
  use 'tpope/vim-surround'
  -- Git helper
  use 'tpope/vim-fugitive'
  -- Gitsigns - Used only for showing blame per line on virtual text
  use 'lewis6991/gitsigns.nvim'
  -- Information statusline
  use 'hoob3rt/lualine.nvim'
  -- Set the root directory to the folder of the current buffer. really useful
  use 'airblade/vim-rooter'
  -- Helper for commenting, works with multiple languages
  use 'scrooloose/nerdcommenter'
  -- Helper to run specific tests and test files
  use 'janko/vim-test'
  -- HTML / CSS dynamic snippet generator
  use 'mattn/emmet-vim'
  -- Theme Night owl
  use 'theminimalistdeveloper/night-owl.nvim'
  -- Enable navigation between nvim and tmux windows using <c-(h,j,k,l)>
  use 'christoomey/vim-tmux-navigator'
end)

-- PLUGINS CONFIGURATION
-------------------------------------------------------------------------------

-- Nvimtree
require 'nvim-tree'.setup()

-- Gitsigns
require 'gitsigns'.setup({ current_line_blame = true })

-- Telescope
local telescope = require 'telescope'
telescope.setup({
  defaults = {},
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  }
})
telescope.load_extension('fzf')

-- Vim Rooter
-- considers switches to the folder of the current buffer if it finds some of the files listed below
vim.g.rooter_patterns = { '.git', 'package.json' }

-- CMP
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local tabnine = require 'cmp_tabnine.config'
local sources = {
  { name = 'nvim_lsp', max_item_count = 5 },
  { name = 'cmp_tabnine', max_item_count = 2 },
  { name = 'buffer' },
  { name = 'path' },
  { name = 'treesitter' },
  { name = 'ultisnips' },
}
local formats = {
  nvim_lsp = ' LSP',
  cmp_tabnine = ' Tabnine',
  buffer = '﬘ Buffer',
  path = ' Path',
  treesitter = ' Treesitter',
  ultisnips = ' Snippets',
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  experimental = { ghost_text = { hl_group = 'LineNr' } },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources(sources),
  formatting = {
    format = lspkind.cmp_format({
      -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      mode = 'symbol_text',
      maxwidth = 40, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]

        local menu = sources[entry.source.name]

        if entry.source.name == 'cmp_tabnine' then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail
          end
        end

        vim_item.menu = menu
        vim_item.kind = formats[entry.source.name]

        return vim_item
      end,
    }),
  },
  mapping = {
    -- loop through the cmp suggestions using Tab
    ['<Tab>'] = cmp.mapping({
      i = cmp.mapping.select_next_item({ select = true }),
      c = cmp.mapping.select_next_item({ select = true }),
    }),
    --- loop back cmp suggestions using Shift + Tab
    ['<S-Tab>'] = cmp.mapping({
      i = cmp.mapping.select_prev_item({ select = true }),
      c = cmp.mapping.select_prev_item({ select = true }),
    }),
    -- close suggestions from cmp mode using Esc
    ['<Esc>'] = cmp.mapping({
      c = cmp.mapping.close()
    }),
    -- select suggestions from cmp using Enter
    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ select = true }),
    }),
  },
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

-- Tabnine
tabnine:setup({
  max_lines = 1000;
  max_num_results = 2;
  sort = true;
  run_on_every_keystroke = true;
  snippet_placeholder = '..';
})
