return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require("nvim-tree").setup({
      view = {
        relativenumber = true,
        width = 40
      },
      filters = { dotfiles = false }
    })
  end,
  keys = {
    { '<leader>oo', '<cmd>NvimTreeToggle<cr>', mode='n'},
    { '<leader>of', '<cmd>NvimTreeFindFile!<cr>', mode='n'},
  },
}
