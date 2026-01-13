-- MAPPINGS
--------------------------------------------------------------------------------

-- Map the leader key to space. *very* important
vim.g.mapleader = " "

-- GENERAL COMMANDS
--------------------------------------------------------------------------------
-- Write current buffer, with the flags to allow to create new folders
vim.keymap.set('n', '<leader>r', '<cmd>write ++p<cr>', { desc = "Save file" })
-- Clean search
vim.keymap.set('n', '<leader>/', '<cmd>noh<cr>', { desc = "Clear search highlighting" })
-- Quit all buffers at once without saving anything
vim.keymap.set('n', '<leader>qq', '<cmd>qall!<cr>', { desc = "Quit all without saving" })
vim.keymap.set('v', '<C-l>', '<cmd>lua print(vim.fn.wordcount().visual_words)<cr>', { desc = "Count selected words" })
-- Reload the current file
vim.keymap.set('n', '<leader>e', '<cmd>e!<cr>', { desc = "Reload current file" })

-- BUFFERS - $B
--------------------------------------------------------------------------------
-- Go to next buffer
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>', { desc = "Next buffer" })
-- Go to previous buffer
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>', { desc = "Previous buffer" })
-- Toggle between last two buffers
vim.keymap.set('n', '<leader>bb', '<cmd>b#<cr>', { desc = "Toggle last two buffers" })
---- Delete the current buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>', { desc = "Delete current buffer" })
-- List all buffers
vim.keymap.set('n', '<leader>bl', '<cmd>ls<cr>', { desc = "List all buffers" })
-- Delete all buffers
vim.keymap.set('n', '<leader>bk', '<cmd>bufdo bd!<cr>', { desc = "Delete all buffers" })

-- QUICKFIX - $C
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>cn', '<cmd>cn<cr>', { desc = "Next quickfix entry" })
vim.keymap.set('n', '<leader>cp', '<cmd>cp<cr>', { desc = "Previous quickfix entry" })
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<cr>', { desc = "Close quickfix panel" })

-- LSP - $L
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = "LSP Rename" })
vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "LSP Definition" })
vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = "LSP Hover" })
vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = "LSP Implementation" })
vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = "LSP Signature Help" })
vim.keymap.set('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = "LSP Type Definition" })
vim.keymap.set('n', '<leader>le', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = "LSP References" })
vim.keymap.set('n', '<leader>lds', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', { desc = "LSP Document Symbols" })
vim.keymap.set('n', '<leader>lws', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', { desc = "LSP Workspace Symbols" })
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = "LSP Format File" })
vim.keymap.set('n', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>', { desc = "Previous diagnostic" })
vim.keymap.set('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>', { desc = "Next diagnostic" })

--------------------------------------------------------------------------------
-- WINDOW - $W
vim.keymap.set('n', '<leader>wf', '<C-w>|', { desc = "Maximize window width" })
vim.keymap.set('n', '<leader>wfh', '<C-w>-', { desc = "Decrease window height" })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = "Split window horizontally" })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = "Split window vertically" })
vim.keymap.set('n', '<leader>wq', '<C-w>q', { desc = "Close current window" })
vim.keymap.set('n', '<leader>wj', '<C-w>|', { desc = "Zoom window width" })
vim.keymap.set('n', '<leader>wh', '<C-w>_', { desc = "Zoom window height" })
vim.keymap.set('n', '<leader>wk', '<C-w>=', { desc = "Reset window sizes" })
vim.keymap.set('n', '<leader>wo', '<C-w><C-O>', { desc = "Only window" })

-- NEOVIM CONFIGURATION - $V
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>vm', '<cmd>e ~/.config/nvim/lua/mappings.lua<cr>', { desc='Open mappings' })
vim.keymap.set('n', '<leader>vp', '<cmd>e ~/.config/nvim/lua/plugins/<cr>', { desc='Open plugins folder' })
vim.keymap.set('n', '<leader>vn', '<cmd>e ~/.config/nvim/lua/plugins/mini.lua<cr>', { desc='Open mini plugins' })
vim.keymap.set('n', '<leader>vl', '<cmd>e ~/.config/nvim/lua/lsp.lua<cr>', { desc='Open LSP configuration' })
vim.keymap.set('n', '<leader>vu', '<cmd>e ~/.config/nvim/lua/ui.lua<cr>', { desc='Open UI' })
vim.keymap.set('n', '<leader>vs', '<cmd>e ~/.config/nvim/lua/settings.lua<cr>', { desc='Open settings' })
vim.keymap.set('n', '<leader>vi', '<cmd>e ~/.config/nvim/init.lua<cr>', {desc='test'}, { desc='Open init.lua' })
