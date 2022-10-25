--------------------------------------------------------------------------------
-- MAPPINGS
--------------------------------------------------------------------------------

-- Map the leader key to space. *VERY* important
vim.g.mapleader = " "

-- GENERAL COMMANDS
--------------------------------------------------------------------------------

-- Write current buffer
vim.keymap.set('n', '<leader>r', '<cmd>w<cr>')
-- Write and close current buffer
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')
-- Quit all buffers at once without saving anything
vim.keymap.set('n', '<leader>qq', '<cmd>qall!<cr>')

-- NEOVIM CONFIGURATION
--------------------------------------------------------------------------------

-- Open mappings
vim.keymap.set('n', '<leader>ncm', '<cmd>e ~/.config/nvim/lua/mappings.lua<cr>')
-- Open plugins
vim.keymap.set('n', '<leader>ncp', '<cmd>e ~/.config/nvim/lua/plugins.lua<cr>')
-- Open UI
vim.keymap.set('n', '<leader>ncu', '<cmd>e ~/.config/nvim/lua/ui.lua<cr>')
-- Open LSP
vim.keymap.set('n', '<leader>ncl', '<cmd>e ~/.config/nvim/lua/lsp.lua<cr>')
-- Open settings
vim.keymap.set('n', '<leader>ncs', '<cmd>e ~/.config/nvim/lua/settings.lua<cr>')
-- Open init
vim.keymap.set('n', '<leader>nci', '<cmd>e ~/.config/nvim/init.lua<cr>')

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

-- BUFFERS
--------------------------------------------------------------------------------

-- Go to next buffer
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>')
-- Go to previous buffer
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>')
-- Toggle between last two buffers
vim.keymap.set('n', '<leader>bb', '<cmd>b#<cr>')
-- Delete the current buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>')
-- List all buffers
vim.keymap.set('n', '<leader>bl', '<cmd>ls<cr>')
-- Delete all buffers
vim.keymap.set('n', '<leader>bk', '<cmd>bufdo bd!<cr>')

-- TELESCOPE
--------------------------------------------------------------------------------

-- Search through Neovim commands
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope commands theme=dropdown<cr>')
-- Search through Neovim options
vim.keymap.set('n', '<leader>fvo', '<cmd>Telescope vim_options theme=dropdown<cr>')
-- Search through the loaded configuration files and reload it
vim.keymap.set('n', '<leader>fl', '<cmd>Telescope reloader theme=dropdown<cr>')
-- Searhch through the files known to Git in the current git folder
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope git_files theme=dropdown<cr>')
-- Search through the available Git branches
vim.keymap.set('n', '<leader>fgb', '<cmd>Telescope git_branches theme=dropdown<cr>')
-- Search through the available Git commits
vim.keymap.set('n', '<leader>fgc', '<cmd>Telescope git_commits theme=dropdown<cr>')
-- Search through the avaialble Git stash
vim.keymap.set('n', '<leader>fgs', '<cmd>Telescope git_stash theme=dropdown<cr>')
-- Search through the available buffers
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers theme=dropdown<cr>')
-- Search through the files in the current folder using grep syntax
vim.keymap.set('n', '<leader>fgr', '<cmd>Telescope live_grep theme=dropdown<cr>')
-- Search throug the available Neovim keymap configuration
vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps theme=dropdown<cr>')

-- NVIMTREE
--------------------------------------------------------------------------------

-- Toggle Nvimtree
vim.keymap.set('n', '<leader>nt', '<cmd>NvimTreeRefresh<cr>:NvimTreeToggle<cr>')

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

-- Restart Neovim LSP
vim.keymap.set('n', '<leader>lt', '<cmd>LspRestart<cr>')
-- Rename the current object under the cursor, this will rename all the occurrences
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- Jump to object definition
vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>')
-- Show the information of the object under the cursor
vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<cr>')
-- Jump to implementation
vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- Show signature of the object under the cursor
vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- Jump to type definition
vim.keymap.set('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- Show references of the object under the cursor
vim.keymap.set('n', '<leader>le', '<cmd>lua vim.lsp.buf.references()<cr>')
-- Show document symbol list of the current file
vim.keymap.set('n', '<leader>lds', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
-- Searches for a specific symbol in all the files in the current folder/project
vim.keymap.set('n', '<leader>lws', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
-- Format the current file
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>')
-- Jump to the previous diagnostic entry
vim.keymap.set('n', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>')
-- Jump to the next diagnostic entry
vim.keymap.set('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>')
vim.keymap.set('n', '<leader> ', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>')

-- LANGUAGE SPECIFIC
--------------------------------------------------------------------------------

-- Typescript
-- Run current script with ts-node
vim.keymap.set('n', '<leader>pt', '<cmd>!ts-node %<cr>')

-- Javascript
-- Run current script with node
vim.keymap.set('n', '<leader>pj', '<cmd>!node %<cr>')

-- PLUGINS
--------------------------------------------------------------------------------

-- Emmet
vim.keymap.set('i', '<C-a>', '<Esc>a<C-y>;')

-- Vimspector
vim.keymap.set('n', '<leader>il', '<Plug>VimspectorLaunch')
vim.keymap.set('n', '<leader>ir', '<cmd>VimspectorReset<cr>')
vim.keymap.set('n', '<leader>ic', '<Plug>VimspectorContinue')
vim.keymap.set('n', '<leader>ii', '<Plug>VimspectorRunToTheCursor')
vim.keymap.set('n', '<leader>ib', '<Plug>VimspectorToggleBreakpoint')
vim.keymap.set('n', '<leader>isi', '<Plug>VimspectorStepInto')
vim.keymap.set('n', '<leader>iso', '<Plug>VimspectorStepOut')
vim.keymap.set('n', '<leader>isv', '<Plug>VimspectorStepOver')
