return {
  -- ToggleTerm 插件
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "float", -- 使用浮动终端
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
  },

  -- nvim-dap 插件
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- 配置 Python 调试适配器
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python", -- 调试类型
          request = "launch",
          name = "Launch file",
          program = "${file}", -- 当前文件
          pythonPath = function()
            return vim.fn.exepath("python") -- 自动检测 Python 路径
          end,
        },
      }
    end,
  },

  -- nvim-dap-ui 插件（可选，用于更友好的调试界面）
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
