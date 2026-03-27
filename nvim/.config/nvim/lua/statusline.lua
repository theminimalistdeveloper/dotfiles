-- 1. Neogit Branch Helper
-- Neogit usually populates 'ogit_head' or uses gitsigns if present.
-- This helper checks the most common Neogit/Native buffer variables.
local function get_git_status()
    local branch = vim.b.gitsigns_head or vim.b.neogit_status_branch
    if not branch or branch == '' then
        -- Fallback: check if we are in a git repo manually (cheap check)
        branch = vim.fn.system('git branch --show-current 2> /dev/null'):gsub('\n', '')
    end
    return (branch ~= '') and ('  ' .. branch) or ''
end

-- 2. Mode Highlights (The "Mini" Look)
-- Define colors for different modes
local mode_colors = {
    n = '%#StatusLineNC# NORMAL ',
    i = '%#PmenuSel# INSERT ',
    v = '%#Visual# VISUAL ',
    V = '%#Visual# V-LINE ',
    ['\22'] = '%#Visual# V-BLOCK ',
    c = '%#DiffChange# COMMAND ',
    R = '%#DiffDelete# REPLACE ',
}

-- 3. Main Render Function
function _G.statusline_render()
    local mode_code = vim.api.nvim_get_mode().mode
    local mode_str = mode_colors[mode_code] or mode_colors['n']

    -- 0.12 Diagnostic Integration
    local diagnostics = vim.diagnostic.status()
    diagnostics = (diagnostics ~= '') and (' ' .. diagnostics) or ''

    -- File info
    local file_name = ' %F %m %r'
    local git = get_git_status()

    -- LSP Info (Your original logic)
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local lsp_str = ''
    if #clients > 0 then
        local names = {}
        for _, c in ipairs(clients) do
            table.insert(names, c.name)
        end
        lsp_str = '  ' .. table.concat(names, ', ')
    end

    -- Construction
    return table.concat({
        mode_str,
        '%#StatusLine#', -- Reset highlighting for the rest of the line
        git,
        diagnostics,
        file_name,
        '%=', -- Right-align split
        lsp_str,
        ' %y ', -- Filetype
        ' %l:%c - Buffer %n %% ', -- Location
    })
end

vim.opt.statusline = '%!v:lua.statusline_render()'
