--------------------------------------------------------------------------------
-- LUALINE - CATPPUCCIN THEME
--------------------------------------------------------------------------------

local colors = {
  base     = '#24273a',
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
    a = { fg = colors.mauve, bg = colors.base },
    b = { fg = colors.sapphire, bg = colors.base },
    c = { fg = colors.flamingo, bg = colors.base },
    x = { fg = colors.flamingo, bg = colors.base },
    z = { fg = colors.flamingo, bg = colors.base },
  },
  insert = {
    a = { fg = colors.red, bg = colors.base },
    z = { fg = colors.base, bg = colors.base },
  },
  visual = {
    a = { fg = colors.green, bg = colors.base },
    z = { fg = colors.base, bg = colors.base },
  },
  replace = {
    a = { fg = colors.blue, bg = colors.base },
    z = { fg = colors.flamingo, bg = colors.base },
  },
  inactive = {
    a = { fg = colors.flamingo, bg = colors.base },
    b = { fg = colors.flamingo, bg = colors.base },
    c = { fg = colors.flamingo, bg = colors.base },
  },
}

require('lualine').setup {
  options = {
    theme = 'nord',
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode', },
    lualine_b = {'branch', 'diagnostics' },
    lualine_c = {
      {
        'diff',
        symbols = {
          added = '󰜄 ',
          modified = '󰝤 ',
          removed = '󰛲 ',
        },
      },
      'searchcount',
    },
    lualine_x = {
      {
        'lsp_status',
        symbols = {
          separator = ' / ',
        },
      }
    },
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {
    lualine_a = {
      {
        'filetype',
        icon_only = true,
      },
      {
         'filename',
         path = 3,
      },
      'filesize',
      {
        'fileformat',
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        },
      },
      'encoding',
    },
  },
  inactive_winbar = {
    lualine_c = {
      {
        'filetype',
        icon_only = true,
      },
      'filename',
    },
  },
  tabline = {},
  extensions = {},
}
