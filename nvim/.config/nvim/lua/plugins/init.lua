-------------------------------------------------------------------------------
-- PLUGINS
-------------------------------------------------------------------------------
---@diagnostic disable: undefined-global

-- Automatically require all plugin files
local plugins = {}
local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", true, true)

for _, file in ipairs(plugin_files) do
  local filename = vim.fn.fnamemodify(file, ":t:r") -- Get filename without extension
  if filename ~= "init" then -- Skip init.lua to avoid circular dependency
    require("plugins/" .. filename)
  end
end
