vim.lsp.config['docker_compose_language_service'] = {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml.docker-compose', 'yaml' },
  root_markers = { 'docker-compose.yml', 'docker-compose.yaml', 'compose.yml', 'compose.yaml' },
  settings = {}
}
