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
      local mode, mode_hl = require('mini.statusline').section_mode({ trunc_width = 120 })
      local git = require('mini.statusline').section_git({ trunc_width = 75 })
      local diagnostics = require('mini.statusline').section_diagnostics({ trunc_width = 75 })
      local filename = require('mini.statusline').section_filename({ trunc_width = 140 })
      local fileinfo = require('mini.statusline').section_fileinfo({ trunc_width = 120 })
      local location = require('mini.statusline').section_location({ trunc_width = 75 })

      return require('mini.statusline').combine_groups({
        { hl = mode_hl, string = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'StatuslineLSP', strings = { lsp_info() } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
})
