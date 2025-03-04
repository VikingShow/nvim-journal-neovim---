-- plugins/journal.lua
return {
  "VikingShow/nvim-journal-neovim---", -- 替换为你的 journal 插件的 GitHub 用户名/仓库名
  dependencies = {
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-lua/plenary.nvim" },
    --    {
    --      "tpope/vim-fugitive", -- Git support (optional)
    --      cond = function()
    --        return require("journal.config").options.git_enabled
    --      end,
    --    },
  },
  config = function()
    require("telescope").setup({})
    require("journal").setup({
      -- 这里可以配置你的 journal 插件的选项
      journal_dir = vim.fn.expand("~/Documents/diary/"),
      file_extension = ".md",
      date_format = "%Y-%m-%d",
      template_file = vim.fn.expand("~/.config/nvim/lua/journal/template.md"),
      git_enabled = true,
    })

    -- 定义快捷键 (可选)
    vim.keymap.set("n", "<leader>jn", "<cmd>JournalNew<cr>", { desc = "Create New Journal Entry" })
    vim.keymap.set("n", "<leader>jo", "<cmd>JournalOpen<cr>", { desc = "Open Journal Entry" })
    vim.keymap.set("n", "<leader>jd", "<cmd>JournalDelete<cr>", { desc = "Delete Journal Entry" })
    vim.keymap.set("n", "<leader>js", "<cmd>JournalStats<cr>", { desc = "Show Journal Status" })
  end,
  -- event = "VeryLazy", -- 可以设置插件加载的时机 (可选)
}
