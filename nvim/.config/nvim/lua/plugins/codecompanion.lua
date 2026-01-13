vim.pack.add({
  'https://github.com/olimorris/codecompanion.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/github/copilot.vim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
})

require('codecompanion').setup({
  display = {
    action_palette = {
      provider = 'mini_pick'
    }
  },
  strategies = {
    chat = {
      adapter = {
        name='copilot',
        model= 'gemini-3-pro-preview',
      },
      keymaps = {
        send = {
          i = '<C-CR>',
          n = '<CR>',
          v = '<CR>',
        },
      },
    },
    inline = {
      adapter = {
        name='copilot',
        model= 'gemini-3-pro-preview',
      },
      keymaps = {
        accept_change = {
          modes = { n = 'ga' },
          description = 'Accept the suggested change',
        },
        reject_change = {
          modes = { n = 'gr' },
          opts = { nowait = true },
          description = 'Reject the suggested change',
        },
      },
    },
    cmd = {
      adapter = {
        name='copilot',
        model= 'gemini-3-pro-preview',
      },
    },
  },
})

vim.keymap.set('n', '<leader>aa', '<cmd>CodeCompanionActions<cr>', {desc='CodeCompanion Actions'})
vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', {desc='Toggle CodeCompanion Chat'})
vim.keymap.set('v', '<leader>ad', '<cmd>CodeCompanionAdd<cr>', {desc='CodeCompanion Add'})
vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanion /explain<cr>', {desc='CodeCompanion Explain'})
