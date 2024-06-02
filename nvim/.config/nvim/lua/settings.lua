--------------------------------------------------------------------------------
-- BASIC SETTINGS
--------------------------------------------------------------------------------

-- Change the terminal title
vim.o.title = true
-- No backup file
vim.o.backup = false
vim.o.swapfile = false
-- Used to determine how many ms the CursorHold autocommand should wait before
-- kicking in
vim.o.updatetime = 250
-- Undo settings, keep a much longer history of
-- undoes even between sessions by storing in an external file
vim.o.undodir = vim.env.HOME .. '/.undodir'
vim.b.undofile = true
-- Hides the buffer instead of closing the files
vim.o.hidden = true
-- Ignore case when searching
vim.o.ignorecase = true
-- Show search matches as you type
vim.o.incsearch = true
-- Let the cursor go anywhere in all modes
vim.o.virtualedit = 'all'
-- Show a list when pressing tab and complete
vim.o.wildmode = 'list:longest,full'
-- Convert tab to spaces
vim.o.expandtab = true
-- Set tab to be 2 spaces
vim.o.tabstop = 4
-- Define the number of spaces used for the auto indent
vim.o.shiftwidth = 4
-- The count of lines go from the current line instead of the top of
-- the file
vim.o.relativenumber = true
-- Set line number
vim.o.number = true
-- Dont wrap lines
vim.o.wrap = false
-- Allow backspace over everything in edit mode
vim.o.backspace = 'indent,eol,start'
-- Set multiples of shiftwidth when indenting with '<'
vim.o.shiftround = false
-- Use case sensitive when the terms are not all in smallcase
vim.o.smartcase = true
-- Show not visible characters
vim.o.list = true
vim.o.listchars = 'trail:⋅,space:⋅'
-- Uses the indentation to determine where to create folds
vim.o.foldmethod = 'indent'
-- auto complete options
vim.o.completeopt = 'menuone,noinsert'
-- Set the identation on
vim.cmd 'filetype plugin indent on';
-- Enable filetype plugins
vim.cmd 'filetype plugin on'
-- Enables syntax highlight
-- Disable Ruby provider
vim.g.loaded_ruby_provider = 0
-- Disable Perl provider
vim.g.loaded_perl_provider = 0
