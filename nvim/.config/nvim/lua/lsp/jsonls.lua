local schemastore = require('schemastore')
vim.lsp.config['jsonls'] = {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { 'package.json', '.git' },
  settings = {
    json = {
      schemastore.json.schemas(),
      validate = { enable = true }
    }
  }
}
