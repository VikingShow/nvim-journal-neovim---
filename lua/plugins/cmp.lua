return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP 补全源
      "hrsh7th/cmp-path", -- 文件路径补全
      "hrsh7th/cmp-buffer", -- 缓冲区补全
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
      })
    end,
  },
}
