vim.lsp.config['emmet-language-server'] = {
  cmd = {'emmet-language-server', '--stdio'},
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'css',
    'vue',
    'astro',
    'svelte'
  }, 
  root_markers = {
    'biome.json',
    'biome.jsonc',
    'package.json',
    '.git'
  },
}
