vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/olimorris/codecompanion.nvim',
})

require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = {
        name = 'copilot',
        model = 'gpt-5-mini',
      }
    },
    inline = {
      adapter = {
        name = 'copilot',
        model = 'gpt-5-mini',
      }
    }
  }
})

-- Keybindings
vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
vim.keymap.set("v", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanion Chat" })
vim.keymap.set("v", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanion Chat" })
vim.keymap.set("v", "<leader>ae", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to Chat" })
vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion Inline" })
