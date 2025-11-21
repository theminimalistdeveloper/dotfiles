--------------------------------------------------------------------------------
-- UI
--------------------------------------------------------------------------------
---@diagnostic disable: undefined-global

-- Fix sign column (the column before the numbers) to avoid layout shifting
vim.o.signcolumn = 'yes:1'
-- Hide unused command line
vim.o.ls = 0
vim.o.ch = 0
-- Enables 24-bit RGB color in the |TUI|
vim.o.termguicolors = true
-- Set 4 lines on the edge of the screen
vim.o.scrolloff = 4
-- Highlight cursor line
vim.o.cursorline = true
-- Show column markers at column 80 and 100
vim.o.colorcolumn = "80"
-- One status line for Neovim instance instead one per window
vim.o.laststatus = 3
-- Set default theme
vim.cmd 'colorscheme onenord'
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi NonText ctermbg=NONE guibg=NONE
  hi NvimTreeNormal guibg=NONE ctermbg=NONE
  hi InactiveWindow guibg=NONE ctermbg=NONE
]]
