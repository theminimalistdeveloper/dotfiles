vim.pack.add({
  'https://github.com/saghen/blink.cmp',
  'https://github.com/rafamadriz/friendly-snippets'
})

require('blink.cmp').setup({
  keymap = {
    preset = 'none',
    ['<Tab>'] = { 'select_and_accept' },
    ['<S-j>'] = { 'select_next' },
    ['<S-k>'] = { 'select_prev' },
    ['<S-f>'] = { 'scroll_documentation_down' },
    ['<S-d>'] = { 'scroll_documentation_up' },
    ['<S-s>'] = { 'show_signature' },
  }
})
