-- ui.lua
local M = {}

function M.show_stats_popup(num_entries, total_words)
  local lines = {
    "Journal Statistics:",
    "Number of entries: " .. num_entries,
    "Total_words: " .. total_words,
  }

  vim.api.nvim_open_win(0, true, {
    relative = "editor",
    width = 40,
    height = 5,
    row = vim.o.lines / 2 - 2,
    col = vim.o.columns / 2 - 20,
    style = "minimal",
  })

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
  vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buf)
end

return M
