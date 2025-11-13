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

-- nvim-cmp highlights using Nord colors for dark background
vim.api.nvim_set_hl(0, 'CmpPmenu', { bg = '#3b4252', fg = '#d8dee9' })
vim.api.nvim_set_hl(0, 'CmpSel', { bg = '#5e81ac', fg = '#eceff4', bold = true })
vim.api.nvim_set_hl(0, 'CmpDoc', { bg = '#2e3440', fg = '#e5e9f0' })
vim.api.nvim_set_hl(0, 'CmpItemKind', { fg = '#88c0d0', bold = true })
vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#81a1c1', italic = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbr', { fg = '#d8dee9' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#bf616a', bold = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#d08770', bold = true })
vim.api.nvim_set_hl(0, 'CmpScrollbar', { bg = '#4c566a' })

-- LSP Diagnostic highlights using Nord colors for dark background
vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#bf616a', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#d08770', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#5e81ac', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#a3be8c', bold = true })

-- Underline styles for inline diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { sp = '#bf616a', undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { sp = '#d08770', undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { sp = '#5e81ac', undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { sp = '#a3be8c', undercurl = true })

-- Virtual text (inline diagnostic messages)
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { fg = '#bf616a', bg = '#3b2f32', italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { fg = '#d08770', bg = '#3b3329', italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { fg = '#5e81ac', bg = '#2d3139', italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = '#a3be8c', bg = '#2f3630', italic = true })

-- Floating window diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { fg = '#bf616a', bg = '#3b4252' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn', { fg = '#d08770', bg = '#3b4252' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo', { fg = '#5e81ac', bg = '#3b4252' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { fg = '#a3be8c', bg = '#3b4252' })

-- Sign column (gutter) diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticSignError', { fg = '#bf616a', bg = '#2e3440' })
vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { fg = '#d08770', bg = '#2e3440' })
vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { fg = '#5e81ac', bg = '#2e3440' })
vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = '#a3be8c', bg = '#2e3440' })
vim.o.winbar = '%m %f'
