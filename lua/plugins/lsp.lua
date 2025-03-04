return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "pyright" }, -- 安装 Pyright 语言服务器
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {}, -- 使用 Pyright 作为 Python 的语言服务器
      },
    },
  },
}
