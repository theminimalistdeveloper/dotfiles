vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' })

local theme = require('../theme-palete')

local function lsp_clients()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ''
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return ' ' .. table.concat(names, ', ')
end

local catppuccin_theme_transparent = {
  normal = {
    a = { bg = theme.blue, fg = theme.base, gui = 'bold' },
    b = { bg = theme.surface1, fg = theme.text },
    c = { bg = 'NONE', fg = theme.text },
  },
  insert = {
    a = { bg = theme.green, fg = theme.base, gui = 'bold' },
    b = { bg = theme.surface1, fg = theme.text },
    c = { bg = 'NONE', fg = theme.text },
  },
  visual = {
    a = { bg = theme.mauve, fg = theme.base, gui = 'bold' },
    b = { bg = theme.surface1, fg = theme.text },
    c = { bg = 'NONE', fg = theme.text },
  },
  replace = {
    a = { bg = theme.red, fg = theme.base, gui = 'bold' },
    b = { bg = theme.surface1, fg = theme.text },
    c = { bg = 'NONE', fg = theme.text },
  },
  command = {
    a = { bg = theme.peach, fg = theme.base, gui = 'bold' },
    b = { bg = theme.surface1, fg = theme.text },
    c = { bg = 'NONE', fg = theme.text },
  },
  inactive = {
    a = { bg = theme.surface0, fg = theme.subtext0 },
    b = { bg = theme.surface0, fg = theme.subtext0 },
    c = { bg = 'NONE', fg = theme.subtext0 },
  },
}

require('lualine').setup({
  options = {
    globalstatus = true,
    theme = catppuccin_theme_transparent,
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_x = { lsp_clients, 'encoding', 'fileformat', 'filetype' },
  },
})
