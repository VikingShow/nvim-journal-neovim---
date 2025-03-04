--core.lua
local config = require("journal.config")
local ui = require("journal.ui")
local template = require("journal.template")
--local utils = require("journal.utils")
local git = require("journal.git")
local plenary = require("plenary.path")

local M = {}

function M.setup()
  if config.options.git_enable then
    git.setup()
  end
end

function M.new_entry()
  local date_str = os.date(config.options.date_format)
  local filename = config.options.journal_dir .. "/" .. date_str .. config.options.file_extension

  local path = plenary:new(filename)
  if path:exists() then
    vim.notify("Journal entry already exists for today.", vim.log.levels.WARN)
    vim.cmd("edit " .. filename)
    return
  end

  local template_content = template.get_template()
  vim.cmd("edit " .. filename)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(template_content, "\n"))
  vim.cmd("w")
  if config.options.git_enable then
    git.add_file(filename)
  end
end

function M.open_entry()
  local telescope = require("telescope")
  telescope.setup({})
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local actions = require("telescope.actions")

  local files = vim.fn.glob(config.options.journal_dir .. "/*" .. config.options.file_extension, true, 1)

  pickers
    .new({}, {
      prompt_title = "Journal Entries",
      finder = finders.new_table({
        results = files,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry:gsub(config.options.journal_dir .. "/", ""):gsub(config.options.file_extension, ""),
            ordinal = entry:gsub(config.options.journal_dir .. "/", ""):gsub(config.options.file_extension, ""),
          }
        end,
      }),
      sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        map("n", "<CR>", actions.select_default(prompt_bufnr))
        return true
      end,
    })
    :find()
end

function M.delete_entry()
  --local telescope = require("telescope")
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local actions = require("telescope.actions")
  local actions_state = require("telescope.actions.state")

  local files = vim.fn.glob(config.options.journal_dir .. "/*" .. config.options.file_extension, true, 1)

  pickers
    .new({}, {
      prompt_title = "Journal Entries",
      finder = finders.new_table({
        results = files,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry:gsub(config.options.journal_dir .. "/", ""):gsub(config.options.file_extension, ""),
            ordinal = entry:gsub(config.options.journal_dir .. "/", ""):gsub(config.options.file_extension, ""),
          }
        end,
      }),
      sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        map("n", "<CR>", function()
          actions.select_default(prompt_bufnr)
          local selection = actions_state.get_selected_entry()
          if not selection or not selection.value then
            vim.notify("No file to delete", vim.log.levels.ERROR)
            return
          end
          local filename = selection.value

          vim.ui.input({ prompt = "Are you sure you want to delete this entry? (y/n): " }, function(input)
            if input == "y" then
              -- Use Lua's os.remove for safer file deletion
              local success, err = os.remove(filename)

              if success then
                vim.notify("Journal entry deleted.", vim.log.levels.INFO)

                -- Close the picker and refresh the list
                actions.close(prompt_bufnr)
                M.delete_entry() -- Reopen picker to refresh the list
              else
                vim.notify("Failed to delete journal entry: " .. err, vim.log.levels.ERROR)
              end

              -- Git integration (if enabled)
              if config.options.git_enable then
                git.remove_file(filename)
                vim.notify("Git integration not implemented.", vim.log.levels.WARN)
              end
            else
              vim.notify("Deletion cancelled", vim.log.levels.INFO)
            end
          end)
        end)
        return true
      end,
    })
    :find()
end

function M.search_entries()
  local telescope = require("telescope")
  --telescope.setup()
  telescope.extensions.live_grep.live_grep()
end

function M.add_tag()
  vim.ui.input({ prompt = "Enter tag: " }, function(tag)
    if tag and tag ~= "" then
      local current_line = vim.api.nvim_get_current_line()
      vim.api.nvim_set_current_line(current_line .. " #" .. tag)
    end
  end)
end

function M.sync_entries()
  local command = config.options.sync_command .. " " .. config.options.journal_dir .. "~/Public/"
  vim.cmd("silent !" .. command)
  vim.notify("Journal entries synced", vim.log.levels.INFO)
end

function M.show_stats()
  local files = vim.fn.glob(config.options.journal_dir .. "/*" .. config.options.file_extension, true, 1)
  local num_entries = #files
  local total_words = 0

  for _, file in ipairs(files) do
    local content = vim.fn.readfile(file)
    for _, line in ipairs(content) do
      total_words = total_words + #vim.split(line, "%s+")
    end
  end

  ui.show_stats_popup(num_entries, total_words)
  vim.notify("Stats: " .. num_entries .. " entries, " .. total_words .. " words.", vim.log.levels.INFO)
end

return M
