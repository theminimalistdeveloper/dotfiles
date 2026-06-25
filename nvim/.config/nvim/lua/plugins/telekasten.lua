return {
  'nvim-telekasten/telekasten.nvim',
  dependencies = {
    'nvim-telekasten/calendar-vim',
  },
  config = function()
    local tk = require('telekasten')
    local home_dir = vim.fn.expand('~/Notes')
    local templates_dir = vim.fs.joinpath(home_dir, 'templates')

    tk.setup({
      home = vim.fs.joinpath(home_dir, 'inbox'),
      dailies = vim.fs.joinpath(home_dir, 'dailies'),
      weeklies = vim.fs.joinpath(home_dir, 'weeklies'),
      monthles = vim.fs.joinpath(home_dir, 'monthlies'),
      yearlies = vim.fs.joinpath(home_dir, 'yearlies'),

      templates = templates_dir,
      template_new_note = vim.fs.joinpath(templates_dir, 'notes.md'),
      template_new_daily = vim.fs.joinpath(templates_dir, 'dailies.md'),
      template_new_weekly = vim.fs.joinpath(templates_dir, 'weeklies.md'),
      template_new_monthly = vim.fs.joinpath(templates_dir, 'monthlies.md'),
      template_new_yearly = vim.fs.joinpath(templates_dir, 'yearlies.md')
    })
  end,
  keys = {
    { '<leader>kf', '<cmd>Telekasten find_notes<cr>', desc = 'Find notes' },
    { '<leader>kg', '<cmd>Telekasten search_notes<cr>', desc = 'Search notes (grep)' },
    { '<leader>kd', '<cmd>Telekasten goto_today<cr>', desc = 'Go to today (daily)' },
    { '<leader>kw', '<cmd>Telekasten goto_thisweek<cr>', desc = 'Go to this week' },
    { '<leader>kn', '<cmd>Telekasten new_note<cr>', desc = 'New note' },
    { '<leader>kN', '<cmd>Telekasten new_templated_note<cr>', desc = 'New templated note' },
    { '<leader>kl', '<cmd>Telekasten follow_link<cr>', desc = 'Follow link' },
    { '<leader>ky', '<cmd>Telekasten yank_notelink<cr>', desc = 'Yank note link' },
    { '<leader>kb', '<cmd>Telekasten show_backlinks<cr>', desc = 'Show backlinks' },
    { '<leader>kF', '<cmd>Telekasten find_friends<cr>', desc = 'Find friends' },
    { '<leader>ki', '<cmd>Telekasten insert_link<cr>', desc = 'Insert link' },
    { '<leader>kI', '<cmd>Telekasten insert_img_link<cr>', desc = 'Insert image link' },
    { '<leader>kp', '<cmd>Telekasten preview_img<cr>', desc = 'Preview image' },
    { '<leader>kt', '<cmd>Telekasten toggle_todo<cr>', desc = 'Toggle todo' },
    { '<leader>kT', '<cmd>Telekasten show_tags<cr>', desc = 'Show tags' },
    { '<leader>kr', '<cmd>Telekasten rename_note<cr>', desc = 'Rename note' },
    { '<leader>kc', '<cmd>Telekasten show_calendar<cr>', desc = 'Show calendar' },
    { '<leader>kk', '<cmd>Telekasten panel<cr>', desc = 'Telekasten panel' },
  }
}
