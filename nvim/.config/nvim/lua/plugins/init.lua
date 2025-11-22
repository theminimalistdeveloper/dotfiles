-------------------------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------------------------
---@diagnostic disable: undefined-global

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Automatically require all plugin files
local plugins = {}
local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", true, true)

for _, file in ipairs(plugin_files) do
  local filename = vim.fn.fnamemodify(file, ":t:r") -- Get filename without extension
  if filename ~= "init" then -- Skip init.lua to avoid circular dependency
    local plugin_module = require("plugins/" .. filename)
    if type(plugin_module) == "table" then
      table.insert(plugins, plugin_module)
    end
  end
end

require("lazy").setup(plugins, {})
