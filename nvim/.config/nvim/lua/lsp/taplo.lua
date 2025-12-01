vim.lsp.config['taplo'] = {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = { 'Cargo.toml', 'pyproject.toml', '.git' },
  settings = {
    taplo = {
      configFile = {
        enabled = true
      },
      schema = {
        enabled = true,
        catalogs = {
          "https://www.schemastore.org/api/json/catalog.json"
        }
      }
    }
  }
}
