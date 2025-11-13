---@diagnostic disable: undefined-global

local cwd = vim.loop.cwd()

return {
  'nvim-telescope/telescope.nvim',
  config = function()
    require ('telescope').setup({
      defaults = {
        file_ignore_patterns = { 'node_modules', '%.git/', 'target' },
      },
      pickers = {
        find_files = {
          hidden = true,
          previewer = true,
          find_command = {
            'rg',
            '--files',
            '-L'
          },
        },
        live_grep = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-L'
          },
          previewer = true,
        },
      },
    })
  end,
  keys = {
    { '<leader>fc', '<cmd>Telescope commands<cr>', mode = 'n' },
    { '<leader>fvo','<cmd>Telescope vim_options<cr>', mode = 'n' },
    { '<leader>fl', '<cmd>Telescope reloader<cr>', mode = 'n' },
    {
      '<leader>ff', string.format('<cmd>Telescope find_files cwd=%s<cr>', cwd),
      mode = 'n'
    },
    { '<leader>fgf', '<cmd>Telescope git_files<cr>', mode = 'n' },
    { '<leader>fgb', '<cmd>Telescope git_branches<cr>', mode = 'n' },
    { '<leader>fgc', '<cmd>Telescope git_commits<cr>', mode = 'n' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', mode = 'n' },
    {
      '<leader>fgr', string.format('<cmd>Telescope live_grep cwd=%s<cr>', cwd),
      mode = 'n'
    },
  },
}
