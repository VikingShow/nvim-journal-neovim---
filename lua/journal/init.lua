--init.lua
local core = require("journal.core")
--local ui = require("journal.ui")
local config = require("journal.config")

local M = {}

function M.setup(opts)
  config.setup(opts)
  if config.options.git_enable then
    core.setup()
  end
end

function M.new_entry()
  core.new_entry()
end

function M.open_entry()
  core.open_entry()
end

function M.delete_entry()
  core.delete_entry()
end

function M.search_entries()
  core.search_entries()
end

function M.add_tag()
  core.add_tag()
end

function M.sync_entries()
  core.sync_entries()
end

function M.show_stats()
  core.show_stats()
end

--定义neovim命令
vim.api.nvim_create_user_command("JournalNew", M.new_entry, {})
vim.api.nvim_create_user_command("JournalOpen", M.open_entry, {})
vim.api.nvim_create_user_command("JournalDelete", M.delete_entry, {})
vim.api.nvim_create_user_command("JournalSearch", M.search_entries, {})
vim.api.nvim_create_user_command("JournalAddTag", M.add_tag, {})
vim.api.nvim_create_user_command("JournalSync", M.sync_entries, {})
vim.api.nvim_create_user_command("JournalStats", M.show_stats, {})

--require("journal").setup({
--  journal_dir = vim.fn.expand("~/Documents/diary"),
--  template_file = vim.fn.expand("~/.config/nvim/lua/journal/template.md"),
--  git_enable = true,
--})(
--  "lua require('journal').setup({ journal_dir = expand('~/Documents/diary'), template_file = expand('~/.config/nvim/lua/journal/template.md'), git_enabled = true })"
--)

return M
