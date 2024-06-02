--------------------------------------------------------------------------------
-- LUALINE - NIGHT OWL THEME
--------------------------------------------------------------------------------

local colors = {
    base     = '#303446',
    blue     = '#8caaee',
    sapphire = '#85c1dc',
    crust    = '#232634',
    red      = '#e78284',
    mauve    = '#ca9ee6',
    flamingo = '#eebebe',
    green    = '#a6d189',
}

local theme = {
    normal = {
        a = { fg = colors.base, bg = colors.mauve },
        b = { fg = colors.base, bg = colors.sapphire },
        c = { fg = colors.flamingo, bg = colors.base },
        x = { fg = colors.flamingo, bg = colors.base },
        z = { fg = colors.flamingo, bg = colors.crust },
    },
    insert = {
        a = { fg = colors.base, bg = colors.red },
        z = { fg = colors.flamingo, bg = colors.crust },
    },
    visual = {
        a = { fg = colors.base, bg = colors.green },
        z = { fg = colors.flamingo, bg = colors.crust },
    },
    replace = {
        a = { fg = colors.base, bg = colors.blue },
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
        lualine_x = { 'diagnostics' },
        lualine_y = {},
        lualine_z = { 'filetype', 'encoding', 'fileformat', 'progress', 'location' },
    },
    tabline = {},
    extensions = {},
}
