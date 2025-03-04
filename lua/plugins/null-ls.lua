return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.black, -- 使用 Black 格式化 Python 代码
          null_ls.builtins.diagnostics.flake8, -- 使用 Flake8 提供诊断
        },
      })
    end,
  },
}
