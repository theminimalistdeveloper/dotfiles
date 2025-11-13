return {
  'hoob3rt/lualine.nvim',
  config = function()
    local colors = {
      bg = '#2e3440',
      fg = '#d8dee9',
      yellow = '#ebcb8b',
      cyan = '#88c0d0',
      darkblue = '#81a1c1',
      green = '#a3be8c',
      orange = '#d08770',
      violet = '#b48ead',
      magenta = '#b48ead',
      blue = '#81a1c1',
      red = '#bf616a',
      nord0 = '#2e3440',
      nord1 = '#3b4252',
      nord2 = '#434c5e',
      nord3 = '#4c566a',
      nord4 = '#d8dee9',
      nord5 = '#e5e9f0',
      nord6 = '#eceff4',
      nord7 = '#8fbcbb',
      nord8 = '#88c0d0',
      nord9 = '#81a1c1',
      nord10 = '#5e81ac',
      nord11 = '#bf616a',
      nord12 = '#d08770',
      nord13 = '#ebcb8b',
      nord14 = '#a3be8c',
      nord15 = '#b48ead'
    }

    local nord = {
      normal = {
        a = { fg = colors.nord0, bg = colors.nord8, gui = 'bold' },
        b = { fg = colors.nord4, bg = colors.nord1 },
        c = { fg = colors.nord4, bg = colors.nord0 },
      },
      insert = {
        a = { fg = colors.nord0, bg = colors.nord14, gui = 'bold' },
        b = { fg = colors.nord4, bg = colors.nord1 },
        c = { fg = colors.nord4, bg = colors.nord0 },
      },
      visual = {
        a = { fg = colors.nord0, bg = colors.nord13, gui = 'bold' },
        b = { fg = colors.nord4, bg = colors.nord1 },
        c = { fg = colors.nord4, bg = colors.nord0 },
      },
      replace = {
        a = { fg = colors.nord0, bg = colors.nord12, gui = 'bold' },
        b = { fg = colors.nord4, bg = colors.nord1 },
        c = { fg = colors.nord4, bg = colors.nord0 },
      },
      command = {
        a = { fg = colors.nord0, bg = colors.nord15, gui = 'bold' },
        b = { fg = colors.nord4, bg = colors.nord1 },
        c = { fg = colors.nord4, bg = colors.nord0 },
      },
      inactive = {
        a = { fg = colors.nord3, bg = colors.nord0, gui = 'bold' },
        b = { fg = colors.nord3, bg = colors.nord0 },
        c = { fg = colors.nord3, bg = colors.nord0 },
      },
    }


    require('lualine').setup {
      options = {
        theme = nord,
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
              added = '+',
              modified = '~',
              removed = '- ',
            },
          },
          'searchcount',
        },
        lualine_x = {
          {
            'lsp_status',
            symbols = {
              separator = ' . ',
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
  end
}
