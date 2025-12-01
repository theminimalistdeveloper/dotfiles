vim.lsp.config['graphql'] = {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql', 'gql', 'typescriptreact', 'javascriptreact' },
  root_markers = { '.graphqlrc', '.graphqlrc.json', 'package.json', '.git' },
  settings = {}
}
