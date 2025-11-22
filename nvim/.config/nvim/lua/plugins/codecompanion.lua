return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'github/copilot.vim',
    'j-hui/fidget.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('codecompanion').setup({
      display = {
        action_palette = {
          provider = "mini_pick"
        }
      },
      strategies = {
        chat = {
          adapter = {
            name="copilot",
            model= "gemini-3-pro-preview",
          },
          keymaps = {
            send = {
              i = "<C-CR>",
              n = "<CR>",
              v = "<CR>",
            },
          },
        },
        inline = {
          adapter = {
            name="copilot",
            model= "gemini-3-pro-preview",
          },
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              opts = { nowait = true },
              description = "Reject the suggested change",
            },
          },
        },
        cmd = {
          adapter = {
            name="copilot",
            model= "gemini-3-pro-preview",
          },
        },
      },
    })
  end,
  keys = {
    { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = 'n' },
    { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', mode = 'n' },
    { '<leader>ad', '<cmd>CodeCompanionAdd<cr>', mode = 'v' },
    { '<leader>ae', '<cmd>CodeCompanion /explain<cr>', mode = 'v' },
  },
}
