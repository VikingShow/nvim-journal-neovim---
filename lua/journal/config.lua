--config.lua
local M = {}

M.options = {
  journal_dir = vim.fn.expand("~/Documents/diary/"),
  file_extension = ".md",
  date_format = "%Y-%m-%d",
  template_file = vim.fn.expand("~/.config/nvim/lua/journal/template.md"),
  sync_command = "rclone sync",
  git_enable = false,
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
  vim.fn.mkdir(M.options.journal_dir, "p")
end
--什么也没改,但我又来了
return M
