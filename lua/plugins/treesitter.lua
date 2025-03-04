return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python" }, -- 确保安装 Python 的解析器
      highlight = { enable = true },
    },
  },
}
