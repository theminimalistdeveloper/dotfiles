-- MAPPINGS
--------------------------------------------------------------------------------
---@diagnostic disable: undefined-global

-- Map the leader key to space. *very* important
vim.g.mapleader = " "

-- GENERAL COMMANDS
--------------------------------------------------------------------------------
-- Write current buffer, with the flags to allow to create new folders
vim.keymap.set('n', '<leader>r', '<cmd>write ++p<cr>')
-- Clean search
vim.keymap.set('n', '<leader>/', '<cmd>noh<cr>')
-- Quit all buffers at once without saving anything
vim.keymap.set('n', '<leader>qq', '<cmd>qall!<cr>')
vim.keymap.set('v', '<C-l>', '<cmd>lua print(vim.fn.wordcount().visual_words)<cr>')

-- BUFFERS - $B
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

-- QUICKFIX - $C
--------------------------------------------------------------------------------
-- Jump to next entry of the quick fix list
vim.keymap.set('n', '<leader>cn', '<cmd>cn<cr>')
-- Jump to previous entry of the quick fix list
vim.keymap.set('n', '<leader>cp', '<cmd>cp<cr>')
-- Close quickfix panel
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<cr>')

-- LSP - $L
--------------------------------------------------------------------------------
-- Stop LSP
vim.keymap.set('n', '<leader>lo', '<cmd>LspStop<cr>')
-- Start LSP
vim.keymap.set('n', '<leader>la', '<cmd>LspStart<cr>')
-- Restart LSP
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
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<cr>')
-- Jump to the previous diagnostic entry
vim.keymap.set('n', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>')
-- Jump to the next diagnostic entry
vim.keymap.set('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>')

-- WINDOW - $W
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
-- Makes the current window the only one open
vim.keymap.set('n', '<leader>wo', '<C-w><C-O>')

-- NEOVIM CONFIGURATION - $V
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
