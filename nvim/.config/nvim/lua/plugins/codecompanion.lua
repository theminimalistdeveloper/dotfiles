vim.pack.add({
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/olimorris/codecompanion.nvim',
})

require('fidget').setup()

local progress = require("fidget.progress")
local handles = {}

local adapter = function()
  local api_key = os.getenv('AI_API_KEY')
  local url = os.getenv('AI_API_URL')

  local ok, adapters = pcall(require, 'codecompanion.adapters')
  if not ok then
    return nil
  end

  return adapters.extend('openai_compatible', {
    name = 'tmd-ai',
    formatted_name = 'TMD AI',
    env = {
      url = url,
      api_key = api_key,
    },
    schema = {
      model = {
        default = 'llama-3.3-70b',
        choices = {
          ['claude-3-haiku'] = {},
          ['claude-3-sonnet'] = {},
          ['claude-3.5-haiku'] = {},
          ['claude-4-opus'] = {},
          ['claude-4-sonnet'] = {},
          ['claude-4-sonnet-global'] = {},
          ['claude-4.1-opus'] = {},
          ['claude-4.5-haiku'] = {},
          ['claude-4.5-haiku-global'] = {},
          ['claude-4.5-opus'] = {},
          ['claude-4.5-opus-global'] = {},
          ['claude-4.5-sonnet'] = {},
          ['claude-4.5-sonnet-global'] = {},
          ['claude-4.6-opus'] = {},
          ['claude-4.6-opus-global'] = {},
          ['claude-4.6-sonnet'] = {},
          ['claude-4.6-sonnet-global'] = {},
          ['claude-4.7-opus'] = {},
          ['claude-4.7-opus-global'] = {},
          ['cohere-embed-v4'] = {},
          ['cohere-embed-v4-global'] = {},
          ['deepseek-r1'] = {},
          ['llama-3.1-70b'] = {},
          ['llama-3.1-8b'] = {},
          ['llama-3.2-11b'] = {},
          ['llama-3.2-1b'] = {},
          ['llama-3.2-3b'] = {},
          ['llama-3.2-90b'] = {},
          ['llama-3.3-70b'] = {},
          ['llama-4-maverick-17b'] = {},
          ['llama-4-scout-17b'] = {},
          ['marengo-embed-2.7'] = {},
          ['marengo-embed-3.0'] = {},
          ['nova-2-lite'] = {},
          ['nova-2-lite-global'] = {},
          ['nova-lite'] = {},
          ['nova-micro'] = {},
          ['nova-premier'] = {},
          ['nova-pro'] = {},
          ['palmyra-x4'] = {},
          ['palmyra-x5'] = {},
          ['pegasus-1.2'] = {},
          ['pegasus-1.2-global'] = {},
          ['pixtral-large'] = {},
          ['stable-conservative-upscale'] = {},
          ['stable-control-sketch'] = {},
          ['stable-control-structure'] = {},
          ['stable-creative-upscale'] = {},
          ['stable-erase-object'] = {},
          ['stable-fast-upscale'] = {},
          ['stable-inpaint'] = {},
          ['stable-outpaint'] = {},
          ['stable-remove-bg'] = {},
          ['stable-search-recolor'] = {},
          ['stable-search-replace'] = {},
          ['stable-style-guide'] = {},
          ['stable-style-transfer'] = {},
        }
      },
    },
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestStarted",
  callback = function(event)
    local buf = event.buf
    local handle = progress.handle.create({
      title = " CodeCompanion",
      message = "Crunching ...",
      lsp_client = { name = "CodeCompanion" },
    })
    handles[buf] = handle
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestFinished",
  callback = function(event)
    local buf = event.buf
    local handle = handles[buf]
    if handle then
      handle:finish()
      handles[buf] = nil
    end
  end,
})

require('codecompanion').setup({
  display = {
    inline = {
      window = {
        layout = 'vertical',
        position = 'right'
      }
    },
    chat = {
      window = {
        layout = 'vertical',
        position = 'right'
      }
    }
  },
  interactions = {
    chat = { adapter = adapter },
    inline = { adapter = adapter },
  },
})

vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle CodeCompanion Chat' })
vim.keymap.set('v', '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion Actions' })
vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanionChat Add<cr>', { desc = 'Add selection to Chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanion<cr>', { desc = 'CodeCompanion Inline' })
