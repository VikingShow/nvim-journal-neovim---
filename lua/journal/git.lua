--git.lua
local config = require("journal.config")

local M = {}

function M.setup()
  local git_status = vim.fn.systemlist("git -C " .. config.options.journal_dir .. " status --porcelain")[1]
  local is_git_repo = git_status ~= nil

  if not is_git_repo then
    vim.notify("Journal directory is not a git repository. Initializing...", vim.log.levels.WARN)
    vim.cmd("silent !git init " .. config.options.journal_dir)
  end
end

function M.add_file(filename)
  vim.cmd("silent !git add " .. filename)
  vim.cmd("silent !git commit -m 'Add journal entry: " .. filename .. "'")
end

function M.remove_file(filename)
  vim.cmd("silent !git rm " .. filename)
  vim.cmd("silent !git commit -m 'Remove journal entry: " .. filename .. "'")
end

return M
