------------------------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------------------------

-- Load the package manager
vim.cmd [[packadd packer.nvim]]

-- PLUGINS LIST
-------------------------------------------------------------------------------

require('packer').startup(function()
    -- Plugin manager
    use { 'wbthomason/packer.nvim' }

    -- LSP
    -- Automatically creates missing LSP diagnostics highlight groups for color
    -- schemes that don't yet support the Neovim 0.5 builtin lsp client.
    use 'folke/lsp-colors.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- sticky header
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'neovim/nvim-lspconfig'
    -- Signature parameters and documentation
    use 'ray-x/lsp_signature.nvim'
    -- Icons for the autocomplete list
    use 'onsails/lspkind-nvim'
    -- Github Copilot
    --use {
    --"zbirenbaum/copilot.lua",
    --}
    --use {
    --"zbirenbaum/copilot-cmp",
    --}

    -- COMPLETION
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- FILE NAVIGATOR
    -- Tree view filesystem navigator
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            -- Adds icons to the file navigator items
            'kyazdani42/nvim-web-devicons',
        },
        tag = 'nightly'
    }

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
    use { "catppuccin/nvim", as = "catppuccin" }
    -- Enable navigation between nvim and tmux windows using <c-(h,j,k,l)>
    use 'christoomey/vim-tmux-navigator'
    -- Debugger
    use 'puremourning/vimspector'
    -- RUST - Cargo dependency helper
    use 'Saecki/crates.nvim'
end)

-- PLUGINS CONFIGURATION
-------------------------------------------------------------------------------
-- Nvimtree
require 'nvim-tree'.setup()

--require("copilot").setup({
--suggestion = { enabled = false },
--panel = { enabled = false },
--})

--require("copilot_cmp").setup()

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
local sources = {
    { name = 'buffer',    max_item_count = 5 },
    --{ name = 'copilot',   max_item_count = 5 },
    { name = 'nvim_lsp',  max_item_count = 100 },
    { name = 'path',      max_item_count = 1 },
    { name = 'ultisnips', max_item_count = 3 },
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
    sources = sources,
    formatting = {
        format = lspkind.cmp_format({
            mode      = 'symbol_text',
            max_width = 50,
            --symbol_map = { Copilot = '' }
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item({ select = true }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ select = true }),
        -- This was removed because it would require 2 Esc's to get out of a suggestion into normal mode
        --['<Esc>'] = cmp.mapping.close(),
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

-- Tabnine
vim.g.vimspector_enable_mappings = 'HUMAN'
