local function lsp_info()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return ""
  end

  local client_names = {}
  for _, client in ipairs(clients) do
    table.insert(client_names, client.name)
  end

  return string.format("  %s", table.concat(client_names, ", "))
end

vim.pack.add({'https://github.com/nvim-mini/mini.statusline'})

require('mini.statusline').setup({
  content = {
    active = function()
      local statusline = require('mini.statusline')
      local mode = statusline.section_mode({ trunc_width = 75 })
      local git = statusline.section_git({ trunc_width = 75 })
      local diff = statusline.section_diff({ trunc_width = 75 })
      local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
      local filename = statusline.section_filename({ trunc_width = 140 })
      local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
      local search_count = statusline.section_searchcount({ trunc_width = 75 })

      return require('mini.statusline').combine_groups({
        { string = { mode, }, strings = { mode:upper()} },
        { strings = { git, diff,  diagnostics } },
        { strings = { filename } },
        '%=',
        { strings = { lsp_info() } },
        { strings = { fileinfo } },
        { strings = { search_count } },
      })
    end,
  },
})
