-- MAPPINGS
--------------------------------------------------------------------------------

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

-- SNIPPETS
--------------------------------------------------------------------------------

local ls = require('luasnip')
vim.keymap.set({ "i", "s" }, "<C-Tab>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-C-Tab>", function() ls.jump(-1) end, { silent = true })

-- QUICKFIX - $C
--------------------------------------------------------------------------------

-- Jump to next entry of the quick fix list
vim.keymap.set('n', '<leader>cn', '<cmd>cn<cr>')
-- Jump to previous entry of the quick fix list
vim.keymap.set('n', '<leader>cp', '<cmd>cp<cr>')
-- Close quickfix panel
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<cr>')

-- DEBUGGER - $D
--------------------------------------------------------------------------------
-- Toggle breakpoint
vim.keymap.set('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<cr>')
-- Continue
vim.keymap.set('n', '<leader>dc', '<cmd>lua require("dap").continue()<cr>')
-- Stop
vim.keymap.set('n', '<leader>dq', '<cmd>lua require("dap").close()<cr>')
-- Step into
vim.keymap.set('n', '<leader>di', '<cmd>lua require("dap").step_into()<cr>')
-- Step over
vim.keymap.set('n', '<leader>do', '<cmd>lua require("dap").step_over()<cr>')
-- Step out
vim.keymap.set('n', '<leader>de', '<cmd>lua require("dap").step_out()<cr>')
-- Inspect state
vim.keymap.set('n', '<leader>ds', '<cmd>lua require("dap").repl.open()<cr>')
-- Toggle the debugger ui
vim.keymap.set('n', '<leader>du', '<cmd>lua require("dapui").toggle()<cr>')

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

-- move around windows
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')


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


-- NEOVIM TREE - $O
--------------------------------------------------------------------------------

-- Neovim Tree toggle in the current directory
vim.keymap.set('n', '<leader>o', '<cmd>NvimTreeToggle<cr>')

-- NOTES - $N
--------------------------------------------------------------------------------

local notes_dir = '~/Notes'

-- Notes, journals
vim.keymap.set('n', '<leader>nt', '<cmd>Neorg journal today<cr>')
vim.keymap.set('n', '<leader>ny', '<cmd>Neorg journal yesterday<cr>')
vim.keymap.set('n', '<leader>no', '<cmd>Neorg journal tomorrow<cr>')
vim.keymap.set('n', '<leader>nc', '<cmd>Neorg journal custom<cr>')
vim.keymap.set('n', '<leader>na', '<cmd>Neorg toc<cr>') -- table of contents
vim.keymap.set('n', '<leader>nn', '<Plug>(neorg.dirman.new-note)')

-- Presenter
vim.keymap.set('n', '<leader>ne', '<Plug>(neorg.presenter.next-page)')
vim.keymap.set('n', '<leader>np', '<Plug>(neorg.presenter.previous-page)')
vim.keymap.set('n', '<leader>nx', '<Plug>(neorg.presenter.close)')

-- Workspaces 
vim.keymap.set('n', '<leader>nwc', '<cmd>Neorg workspace corporate<cr>')
vim.keymap.set('n', '<leader>nwp', '<cmd>Neorg workspace personal<cr>')
vim.keymap.set('n', '<leader>nwd', '<cmd>Neorg workspace default<cr>')

-- metadata
vim.keymap.set('n', '<leader>nm', '<cmd>Neorg inject-metadata<cr>')
vim.keymap.set('n', '<leader>nu', '<cmd>Neorg update-metadata<cr>')

-- Search current workspace
vim.keymap.set(
  'n',
  '<leader>nf', string.format(
  '<cmd>Telescope live_grep search_dirs=%s theme=%s<cr>',
  notes_dir,
  "ivy")
)

-- TELESCOPE - $F
--------------------------------------------------------------------------------

local cwd = vim.loop.cwd()

-- Search through Neovim commands
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope commands<cr>')
-- Search through Neovim options
vim.keymap.set('n', '<leader>fvo','<cmd>Telescope vim_options<cr>')
-- Search through the loaded configuration files and reload it
vim.keymap.set('n', '<leader>fl', '<cmd>Telescope reloader<cr>')
-- Searhc through the files in the current folder
vim.keymap.set('n', '<leader>ff', string.format('<cmd>Telescope find_files cwd=%s<cr>', cwd))
-- Searhc through the files known to Git in the current git folder
vim.keymap.set('n', '<leader>fgf', '<cmd>Telescope git_files<cr>')
-- Search through the available Git branches
vim.keymap.set('n', '<leader>fgb', '<cmd>Telescope git_branches<cr>')
-- Search through the available Git commits
vim.keymap.set('n', '<leader>fgc', '<cmd>Telescope git_commits<cr>')
-- Search through the available buffers
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
-- Search through the files in the current folder using grep syntax
vim.keymap.set('n', '<leader>fgr', string.format('<cmd>Telescope live_grep cwd=%s<cr>', cwd))

-- VIM FUGITIVE - $G
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
vim.keymap.set('n', '<leader>gs', '<cmd>Neogit<cr>')
-- Open Git conflict vertical diff
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit!<cr>')


-- TEST - $E
--------------------------------------------------------------------------------

-- Test the nearest test from the current position
vim.keymap.set('n', '<leader>en', '<cmd>lua require("neotest").run.run()<cr>')
-- Test the current file
vim.keymap.set('n', '<leader>ef', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>')
-- Test the last test done
vim.keymap.set('n', '<leader>el', '<cmd>lua require("neotest").run.run_last()<cr>')
-- Open the output panel
vim.keymap.set('n', '<leader>ep', '<cmd>lua require("neotest").output.open({ enter=true, auto_close=true })<cr>')
-- Clear output panel
vim.keymap.set('n', '<leader>epc', '<cmd>lua require("neotest").output.clear()<cr>')
-- Toggle summary panel
vim.keymap.set('n', '<leader>es', '<cmd>lua require("neotest").summary.toggle()<cr>')
-- Run DAP
vim.keymap.set('n', '<leader>ed', '<cmd>lua require("neotest").run.run({ strategy="dap" })<cr>')

-- Trouble - $T
--------------------------------------------------------------------------------

-- Toggle the trouble window
vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle<cr>')
-- Toggle the trouble window with the current buffer diagnostics
vim.keymap.set('n', '<leader>tb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>')
-- Toggle the trouble window for the symbols
vim.keymap.set('n', '<leader>ts', '<cmd>Trouble symbols toggle focus=false<cr>')
-- Toggle the trouble window for LSP Definitions / references / ...
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>')
-- Toggle the trouble window for the loclist 
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble loclist toggle<cr>')
-- Toggle the trouble window for the quickfix list
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble qflist toggle<cr>')

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

-- TROUBLE - $X
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>')
vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>')
vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>')
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>')
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>')

-- Copilot - $A
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>')

-- MISC
vim.keymap.set('x', '<C-l>', '<cmd>lua print(vim.fn.wordcount().visual_words)<cr>')
