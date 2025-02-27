--template.lua
local config = require("journal.config")
local plenary = require("plenary.path")

local M = {}

function M.get_template()
  local path = plenary:new(config.options.template_file)
  if path:exists() then
    local lines = vim.fn.readfile(config.options.template_file)
    local content = table.concat(lines, "\n")
    local date_str = os.date("%Y-%m-%d %H:%M:%S")
    content = string.gsub(content, "{{date}}", date_str)
    return content
  else
    return "# Journal Entry\n\n" .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n"
  end
end

return M
