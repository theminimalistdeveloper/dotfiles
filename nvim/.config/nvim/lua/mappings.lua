-------------------------------------------------------------------------------- MAPPINGS
--------------------------------------------------------------------------------

-- Map the leader key to space. *VERY* important
vim.g.mapleader = " "

-- Neovim tree
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>')

-- GENERAL COMMANDS
--------------------------------------------------------------------------------

-- Write current buffer
vim.keymap.set('n', '<leader>r', '<cmd>w<cr>')
-- Write and close current buffer
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')
-- Quit all buffers at once without saving anything
vim.keymap.set('n', '<leader>qq', '<cmd>qall!<cr>')

-- QUICKFIX
--------------------------------------------------------------------------------

-- jump to next entry of the quick fix list
vim.keymap.set('n', '<leader>cn', '<cmd>cn<cr>')

-- jump to previous entry of the quick fix list
vim.keymap.set('n', '<leader>cp', '<cmd>cn<cr>')

-- SNIPPETS
--------------------------------------------------------------------------------

local ls = require('luasnip')
vim.keymap.set({ "i", "s" }, "<Tab>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })

-- NEOVIM CONFIGURATION
--------------------------------------------------------------------------------

-- Open mappings
vim.keymap.set('n', '<leader>vm', '<cmd>e ~/.config/nvim/lua/mappings.lua<cr>')
-- Open plugins
vim.keymap.set('n', '<leader>vp', '<cmd>e ~/.config/nvim/lua/plugins.lua<cr>')
-- Open UI
vim.keymap.set('n', '<leader>vu', '<cmd>e ~/.config/nvim/lua/ui.lua<cr>')
-- Open LSP
vim.keymap.set('n', '<leader>vl', '<cmd>e ~/.config/nvim/lua/lsp.lua<cr>')
-- Open settings
vim.keymap.set('n', '<leader>vs', '<cmd>e ~/.config/nvim/lua/settings.lua<cr>')
-- Open init
vim.keymap.set('n', '<leader>vi', '<cmd>e ~/.config/nvim/init.lua<cr>')

-- WINDOW
--------------------------------------------------------------------------------

-- Increase the size of the current window horizontally
vim.keymap.set('n', '<leader>wf', '<C-w>|')
-- Increase the size of the current window vertically
vim.keymap.set('n', '<leader>wfh', '<C-w>-')
-- Create a new window horizontally
vim.keymap.set('n', '<leader>ws', '<C-w>s')
-- Create a new window vertically
vim.keymap.set('n', '<leader>wv', '<C-w>v')
-- Quit the current window
vim.keymap.set('n', '<leader>wq', '<C-w>q')
-- Zoom current window vertically
vim.keymap.set('n', '<leader>wj', '<C-w>|')
-- Zoom current window horizontally
vim.keymap.set('n', '<leader>wh', '<C-w>_')
-- Resets the current Zoom
vim.keymap.set('n', '<leader>wk', '<C-w>=')

-- move around windows
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')


-- BUFFERS
--------------------------------------------------------------------------------

-- Go to next buffer
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>')
-- Go to previous buffer
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>')
-- Toggle between last two buffers
vim.keymap.set('n', '<leader>bb', '<cmd>b#<cr>')
---- Delete the current buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>')
-- List all buffers
vim.keymap.set('n', '<leader>bl', '<cmd>ls<cr>')
-- Delete all buffers
vim.keymap.set('n', '<leader>bk', '<cmd>bufdo bd!<cr>')

-- Notes
--------------------------------------------------------------------------------
local notes_dir = '~/Notes'

-- TELESCOPE
--------------------------------------------------------------------------------
--
local telescope_theme = 'ivy'
-- Search through Neovim commands
vim.keymap.set('n', '<leader>fc', string.format('<cmd>Telescope commands theme=%s<cr>', telescope_theme))
-- Search through Neovim options
vim.keymap.set('n', '<leader>fvo', string.format('<cmd>Telescope vim_options theme=%s<cr>', telescope_theme))
-- Search through the loaded configuration files and reload it
vim.keymap.set('n', '<leader>fl', string.format('<cmd>Telescope reloader theme=%s<cr>', telescope_theme))
-- Searhc through the files in the current folder
vim.keymap.set('n', '<leader>ff', string.format('<cmd>Telescope find_files theme=%s<cr>', telescope_theme))
-- Searhc through the files known to Git in the current git folder
vim.keymap.set('n', '<leader>fgf', string.format('<cmd>Telescope git_files theme=%s<cr>', telescope_theme))
-- Search through the available Git branches
vim.keymap.set('n', '<leader>fgb', string.format('<cmd>Telescope git_branches theme=%s<cr>', telescope_theme))
-- Search through the available Git commits
vim.keymap.set('n', '<leader>fgc', string.format('<cmd>Telescope git_commits theme=%s<cr>', telescope_theme))
-- Search through the avaialble Git stash
vim.keymap.set('n', '<leader>fgs', string.format('<cmd>Telescope git_stash theme=%s<cr>', telescope_theme))
-- Search through the available buffers
vim.keymap.set('n', '<leader>fe', string.format('<cmd>Telescope buffers theme=%s<cr>', telescope_theme))
-- Search through the files in the current folder using grep syntax
vim.keymap.set('n', '<leader>fgr', string.format('<cmd>Telescope live_grep theme=%s<cr>', telescope_theme))
-- Search through the available Neovim keymap configuration
vim.keymap.set('n', '<leader>fk', string.format('<cmd>Telescope keymaps theme=%s<cr>', telescope_theme))
-- Search through the available Neovim keymap configuration
vim.keymap.set('n', '<leader>fb', string.format('<cmd>Telescope file_browser theme=%s<cr>', telescope_theme))
-- Open file navigator in inbox notes
vim.keymap.set('n', '<leader>fni',
    string.format('<cmd>Telescope file_browser path=%s/inbox/ theme=%s<cr>', notes_dir, telescope_theme))
-- Open file navaigator in personal notes
vim.keymap.set('n', '<leader>fnp',
    string.format('<cmd>Telescope file_browser path=%s/personal/ theme=%s<cr>', notes_dir, telescope_theme))
-- Open file navigator in companies notes
vim.keymap.set('n', '<leader>fnc',
    string.format('<cmd>Telescope file_browser path=%s/companies/ theme=%s<cr>', notes_dir, telescope_theme))
-- Grep in notes dir
vim.keymap.set('n', '<leader>fng',
    string.format('<cmd>Telescope live_grep search_dirs={"%s"} theme=%s<cr>', notes_dir, telescope_theme))
-- Find files in notes dir
vim.keymap.set('n', '<leader>fn',
    string.format('<cmd>Telescope find_files search_dirs={"%s"} theme=%s<cr>', notes_dir, telescope_theme))

-- VIM FUGITIVE
--------------------------------------------------------------------------------

-- Git blame on the current file
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>')
-- Git pull
vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<cr>')
-- Git push
vim.keymap.set('n', '<leader>gpu', '<cmd>Git push<cr>')
-- Git log
vim.keymap.set('n', '<leader>gl', '<cmd>Git log<cr>')
-- Git commit
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>')
-- Git status / Git
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')
-- Git vertial diff
vim.keymap.set('n', '<leader>gdv', '<cmd>Gvdiff<cr>')
-- Git vertical diff of master branch
vim.keymap.set('n', '<leader>gdm', '<cmd>Gvdiff master<cr>')
-- Push the current branch as a new branch to repository
vim.keymap.set('n', '<leader>gpnb', '<cmd>!gpnb<cr>')

-- TEST
--------------------------------------------------------------------------------

-- Test the nearest test from the current position
vim.keymap.set('n', '<leader>tn', '<cmd>:TestNearest<CR>')
-- Test the current file
vim.keymap.set('n', '<leader>tf', '<cmd>:TestFile<cr>')
-- Test the current suite
vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<CR>')
-- Test the last test done
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<CR>')

-- LSP
--------------------------------------------------------------------------------

-- Stop LSP
vim.keymap.set('n', '<leader>so', '<cmd>LspStop<cr>')
-- Start LSP
vim.keymap.set('n', '<leader>sa', '<cmd>LspStart<cr>')
-- Restart LSP
vim.keymap.set('n', '<leader>st', '<cmd>LspRestart<cr>')
-- Rename the current object under the cursor, this will rename all the occurrences
vim.keymap.set('n', '<leader>sr', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- Jump to object definition
vim.keymap.set('n', '<leader>sd', '<cmd>lua vim.lsp.buf.definition()<cr>')
-- Show the information of the object under the cursor
vim.keymap.set('n', '<leader>sh', '<cmd>lua vim.lsp.buf.hover()<cr>')
-- Jump to implementation
vim.keymap.set('n', '<leader>si', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- Show signature of the object under the cursor
vim.keymap.set('n', '<leader>ss', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- Jump to type definition
vim.keymap.set('n', '<leader>st', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- Show references of the object under the cursor
vim.keymap.set('n', '<leader>se', '<cmd>lua vim.lsp.buf.references()<cr>')
-- Show document symbol list of the current file
vim.keymap.set('n', '<leader>sds', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
-- Searches for a specific symbol in all the files in the current folder/project
vim.keymap.set('n', '<leader>sws', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
-- Format the current file
vim.keymap.set('n', '<leader>sf', '<cmd>lua vim.lsp.buf.format()<cr>')
-- Jump to the previous diagnostic entry
vim.keymap.set('n', '<leader>sp', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>')
-- Jump to the next diagnostic entry
vim.keymap.set('n', '<leader>sn', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>')
vim.keymap.set('n', '<leader> ', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>')
