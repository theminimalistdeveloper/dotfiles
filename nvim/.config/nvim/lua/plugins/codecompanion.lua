vim.pack.add({
    'https://github.com/j-hui/fidget.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/olimorris/codecompanion.nvim',
})

require('fidget').setup()

-- The name of the environment variable where you keep your Joyia API key
local joyia_api_key = os.getenv('JOYIA_API_KEY')
local joyia_api_url = os.getenv('JOYIA_API_URL')

-- Definition of the custom JOYIA adapter
local joyia_adapter = function()
    local ok, adapters = pcall(require, 'codecompanion.adapters')
    if not ok then
        return nil
    end

    return adapters.extend('openai_compatible', {
        name = 'joyia',
        env = {
            url = joyia_api_url,
            api_key = joyia_api_key,
        },
        schema = {
            model = {
                default = 'claude-opus-4-6',
            },
        },
    })
end

-- Personal adapter - Copilot
local copilot_adapter = function()
    return {
        name = 'copilot',
        model = 'claude-sonnet-4.6',
    }
end

local adapter = (joyia_api_key and joyia_api_url) and joyia_adapter() or copilot_adapter()

-- Integrate fidget.nvim spinner with CodeCompanion
-- This hooks into CodeCompanion events to show/hide a fidget progress notification
local progress = require("fidget.progress")

local handles = {}

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestStarted",
  callback = function(event)
    local buf = event.buf
    local handle = progress.handle.create({
      title = " CodeCompanion",
      message = "Thinking...",
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
