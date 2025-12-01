vim.lsp.config['bashls'] = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
  single_file_support = true,
  settings = {
    bashIde = {
      globPattern = "**/*@(.sh|.inc|.bash|.command)"
    }
  }
}
