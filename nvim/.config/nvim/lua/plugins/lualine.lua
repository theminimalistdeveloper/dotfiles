vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

-- Custom Catppuccin Frappe theme with transparent middle section
local frappe = {
  rosewater = '#f2d5cf',
  flamingo = '#eebebe',
  pink = '#f4b8e4',
  mauve = '#ca9ee6',
  red = '#e78284',
  maroon = '#ea999c',
  peach = '#ef9f76',
  yellow = '#e5c890',
  green = '#a6d189',
  teal = '#81c8be',
  sky = '#99d1db',
  sapphire = '#85c1dc',
  blue = '#8caaee',
  lavender = '#babbf1',
  text = '#c6d0f5',
  subtext1 = '#b5bfe2',
  subtext0 = '#a5adce',
  overlay2 = '#949cbb',
  overlay1 = '#838ba7',
  overlay0 = '#737994',
  surface2 = '#626880',
  surface1 = '#51576d',
  surface0 = '#414559',
  base = '#303446',
  mantle = '#292c3c',
  crust = '#232634',
}

local catppuccin_frappe_transparent = {
  normal = {
    a = { bg = frappe.blue, fg = frappe.base, gui = 'bold' },
    b = { bg = frappe.surface1, fg = frappe.text },
    c = { bg = 'NONE', fg = frappe.text },
  },
  insert = {
    a = { bg = frappe.green, fg = frappe.base, gui = 'bold' },
    b = { bg = frappe.surface1, fg = frappe.text },
    c = { bg = 'NONE', fg = frappe.text },
  },
  visual = {
    a = { bg = frappe.mauve, fg = frappe.base, gui = 'bold' },
    b = { bg = frappe.surface1, fg = frappe.text },
    c = { bg = 'NONE', fg = frappe.text },
  },
  replace = {
    a = { bg = frappe.red, fg = frappe.base, gui = 'bold' },
    b = { bg = frappe.surface1, fg = frappe.text },
    c = { bg = 'NONE', fg = frappe.text },
  },
  command = {
    a = { bg = frappe.peach, fg = frappe.base, gui = 'bold' },
    b = { bg = frappe.surface1, fg = frappe.text },
    c = { bg = 'NONE', fg = frappe.text },
  },
  inactive = {
    a = { bg = frappe.surface0, fg = frappe.subtext0 },
    b = { bg = frappe.surface0, fg = frappe.subtext0 },
    c = { bg = 'NONE', fg = frappe.subtext0 },
  },
}

require('lualine').setup({
  options = {
    theme = catppuccin_frappe_transparent,
  },
})
