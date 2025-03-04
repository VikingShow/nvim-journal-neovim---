return {
  {
    "akinsho/toggleterm.nvim",
    version = "*", -- 安装最新版本
    config = function()
      require("toggleterm").setup({
        size = 20, -- 默认终端高度（水平终端）或宽度（垂直终端）
        open_mapping = [[<c-\>]], -- 打开/关闭终端的快捷键
        hide_numbers = true, -- 隐藏行号
        shade_filetypes = {},
        shade_terminals = true, -- 终端背景阴影
        shading_factor = 2, -- 阴影强度（1-3）
        start_in_insert = true, -- 打开时自动进入插入模式
        persist_size = true, -- 记住终端窗口大小
        direction = "float", -- 终端方向（可选值：'horizontal', 'vertical', 'float'）
        close_on_exit = true, -- 退出终端时关闭窗口
        shell = vim.o.shell, -- 使用默认 shell
        float_opts = {
          border = "curved", -- 浮动终端边框样式（可选值：'single', 'double', 'shadow', 'curved'）
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },
}
