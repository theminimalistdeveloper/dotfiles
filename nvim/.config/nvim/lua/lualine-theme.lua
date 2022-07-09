--------------------------------------------------------------------------------
-- LUALINE - NIGHT OWL THEME
--------------------------------------------------------------------------------

local colors = {
  black  = '#011627',
  blue   = '#82AAFF',
  cyan   = '#7FDBCA',
  grey   = '#639999',
  red    = '#FF5874',
  violet = '#c792ea',
  white  = '#EEEEEE',
  green  = '#ADDB67',
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.black, bg = colors.cyan },
    c = { fg = colors.white, bg = colors.black },
    x = { fg = colors.white, bg = colors.black },
    z = { fg = colors.white, bg = colors.gray },
  },

  insert = {
    a = { fg = colors.black, bg = colors.red },
    z = { fg = colors.white, bg = colors.gray },
  },
  visual = {
    a = { fg = colors.black, bg = colors.green },
    z = { fg = colors.white, bg = colors.gray },
  },
  replace = {
    a = { fg = colors.black, bg = colors.blue },
    z = { fg = colors.white, bg = colors.gray },
  },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
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
    lualine_x = { 'diagnostics' },
    lualine_y = {},
    lualine_z = { 'filetype', 'encoding', 'fileformat', 'progress', 'location' },
  },
  tabline = {},
  extensions = {},
}
