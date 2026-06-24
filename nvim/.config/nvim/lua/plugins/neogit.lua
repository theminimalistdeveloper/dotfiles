vim.pack.add({
    'https://github.com/NeogitOrg/neogit',
    'https://github.com/sindrets/diffview.nvim',
})

local function open_unstaged_files()
  local output = vim.fn.system({'git', 'status', '--porcelain'})

  if vim.v.shell_error ~= 0 then
    vim.notify('Error getting git status', vim.log.levels.ERROR)
    return
  end

  local qflist = {}
  for line in output:gmatch('[^\r\n]+') do
    local status, filepath = line:match('^([AMRDU?%s]+)%s+(.+)$')
    if status and filepath and status:match('[^%s]') then
      table.insert(qflist, {
        filename = filepath,
        lnum = 1,
        col = 1,
        text = 'Unstaged file (' .. status .. ')'
      })
    end
  end

  if #qflist == 0 then
    vim.notify('No unstaged files found', vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist(qflist)
  vim.cmd.copen()
end

local function open_staged_files()
  local output = vim.fn.system({'git', 'status', '--porcelain'})

  if vim.v.shell_error ~= 0 then
    vim.notify('Error getting git status', vim.log.levels.ERROR)
    return
  end

  local qflist = {}
  for line in output:gmatch('[^\r\n]+') do
    local status, filepath = line:match('^([AMRDU?%s]+)%s+(.+)$')
    if status and filepath and status:match('^[%s]*[AMDRU?]$') then
      table.insert(qflist, {
        filename = filepath,
        lnum = 1,
        col = 1,
        text = 'Staged file (' .. status .. ')'
      })
    end
  end

  if #qflist == 0 then
    vim.notify('No staged files found', vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist(qflist)
  vim.cmd.copen()
end

vim.keymap.set('n', '<leader>gs', '<cmd>Neogit<cr>', { desc = 'Neogit Status' })
vim.keymap.set('n', '<leader>gu', open_unstaged_files, { desc = 'Open Unstaged Files' })
vim.keymap.set('n', '<leader>gt', open_staged_files, { desc = 'Open Staged Files' })
