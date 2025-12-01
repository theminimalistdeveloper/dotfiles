local schemastore = require('schemastore')
vim.lsp.config['yamlls'] = {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yml' },
  root_markers = { '.yamllint', '.yamllint.yml', 'package.json', '.git' },
  settings = {
    yaml = {
      schemas = schemastore.yaml.schemas(),
      validate = true,
      completion = true,
      hover = true
    }
  }
}
