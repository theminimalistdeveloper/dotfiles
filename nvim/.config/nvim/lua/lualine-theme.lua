--------------------------------------------------------------------------------
-- LUALINE - CATPPUCCIN THEME
--------------------------------------------------------------------------------

local colors = {
  base     = '',
  blue     = '#8caaee',
  sapphire = '#85c1dc',
  crust    = '#000000',
  red      = '#e78284',
  mauve    = '#ca9ee6',
  flamingo = '#fff',
  green    = '#a6d189',
}

local theme = {
  normal = {
    a = { fg = colors.crust, bg = colors.mauve },
    b = { fg = colors.crust, bg = colors.sapphire },
    c = { fg = colors.flamingo, bg = colors.base },
    x = { fg = colors.flamingo, bg = colors.base },
    z = { fg = colors.flamingo, bg = colors.base },
  },
  insert = {
    a = { fg = colors.crust, bg = colors.red },
    z = { fg = colors.base, bg = colors.base },
  },
  visual = {
    a = { fg = colors.base, bg = colors.green },
    z = { fg = colors.flamingo, bg = colors.crust },
  },
  replace = {
    a = { fg = colors.crust, bg = colors.blue },
    z = { fg = colors.flamingo, bg = colors.crust },
  },
  inactive = {
    a = { fg = colors.flamingo, bg = colors.base },
    b = { fg = colors.flamingo, bg = colors.base },
    c = { fg = colors.flamingo, bg = colors.base },
  },
}

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '·',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename', 'filesize', 'diff' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'filetype', 'fileformat', 'searchcount', 'progress', 'location', 'diagnostics' },
  },
  tabline = {},
  extensions = {},
}
