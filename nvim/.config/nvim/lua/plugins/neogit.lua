return {
  "NeogitOrg/neogit",
  dependencies = {
    "sindrets/diffview.nvim",
  },
  config = true,
  keys = {
    { '<leader>gs', '<cmd>Neogit<cr>', mode = 'n' },
  },
}
