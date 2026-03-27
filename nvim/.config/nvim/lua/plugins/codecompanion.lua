vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/olimorris/codecompanion.nvim',
})

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
        model = 'gpt5-mini',
    }
end

local adapter = (joyia_api_key and joyia_api_url) and joyia_adapter or copilot_adapter

require('codecompanion').setup({
    strategies = {
        chat = { adapter = adapter },
        inline = { adapter = adapter },
    },
})

vim.keymap.set('n', '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion Actions' })
vim.keymap.set('v', '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion Actions' })
vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle CodeCompanion Chat' })
vim.keymap.set('v', '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle CodeCompanion Chat' })
vim.keymap.set('v', '<leader>ae', '<cmd>CodeCompanionChat Add<cr>', { desc = 'Add selection to Chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanion<cr>', { desc = 'CodeCompanion Inline' })
