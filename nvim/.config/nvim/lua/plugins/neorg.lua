return {
  "nvim-neorg/neorg",
  ft = "norg",
  priority = 100, -- Ensure Neorg is loaded before other plugins that depend on it
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function ()
    require('neorg').setup {
      load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode", -- Use the zen mode plugin for distraction-free writing
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              personal = "~/Notes/Personal",
              corporate = "~/Notes/Corporate",
            },
            default_workspace = "personal",
          },
        },
        ["core.concealer"] = {
          config = {
            conceal = true,
            conceal_level = 3
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
      },
    }
  end,
  keys = {
    { '<leader>nt', '<cmd>Neorg journal today<cr>', mode = 'n'},
    { '<leader>ny', '<cmd>Neorg journal yesterday<cr>', mode='n'},
    { '<leader>no', '<cmd>Neorg journal tomorrow<cr>', mode='n'},
    { '<leader>nc', '<cmd>Neorg journal custom<cr>', mode='n'},
    { '<leader>na', '<cmd>Neorg toc<cr>', mode='n'},
    { '<leader>nn', '<Plug>(neorg.dirman.new-note)', mode='n'},
    { '<leader>ne', '<Plug>(neorg.presenter.next-page)', mode='n'},
    { '<leader>np', '<Plug>(neorg.presenter.previous-page)', mode='n'},
    { '<leader>nx', '<Plug>(neorg.presenter.close)', mode='n'},
    { '<leader>nwc', '<cmd>Neorg workspace corporate<cr>', mode='n'},
    { '<leader>nwp', '<cmd>Neorg workspace personal<cr>', mode='n'},
    { '<leader>nwd', '<cmd>Neorg workspace default<cr>', mode='n'},
    { '<leader>nm', '<cmd>Neorg inject-metadata<cr>', mode='n'},
    { '<leader>nu', '<cmd>Neorg update-metadata<cr>', mode='n'},
    {
      '<leader>nf', '<cmd>lua require("telescope.builtin").live_grep({cwd="~/Notes"})<cr>',
      mode='n'
    },
  },
}
