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
        "--branch=stable", -- latest stable release
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
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup({
                filters = {
                    dotfiles = true,
                }
            })
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
    'neovim/nvim-lspconfig',
    -- Signature parameters and documentation
    'ray-x/lsp_signature.nvim',
    -- markdown preview
    { 'iamcco/markdown-preview.nvim',             build = 'cd app && yarn install' },
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
                { name = 'nvim_lsp',  max_item_count = 100 },
                { name = 'buffer',    max_item_count = 5 },
                { name = 'ultisnips', max_item_count = 3 },
                { name = 'path',      max_item_count = 1 },
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

    -- SNIPPETS
    -- Ultisnips - the snippet engine used everywhere
    'sirver/ultisnips',
    -- Initial package of snippets for multiple languages
    'honza/vim-snippets',
    -- Jest snippets
    'jhkersul/vim-jest-snippets',
    -- Necessary to show Ultisnips in the CMP suggestion window
    'quangnguyen30192/cmp-nvim-ultisnips',

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
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

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
    'scrooloose/nerdcommenter',
    -- Helper to run specific tests and test files
    'janko/vim-test',
    -- HTML / CSS dynamic snippet generator
    'mattn/emmet-vim',
    -- Theme Night owl
    'theminimalistdeveloper/night-owl.nvim',
    { "catppuccin/nvim", as = "catppuccin" },
    -- Enable navigation between nvim and tmux windows using <c-(h,j,k,l)>
    'christoomey/vim-tmux-navigator',
    -- RUST - Cargo dependency helper
    'Saecki/crates.nvim'
}

require("lazy").setup(plugins)
