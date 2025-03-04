-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- terminal-toggleterm
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "打开浮动终端" })
vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<CR>", { desc = "打开水平终端" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<CR>", { desc = "打开垂直终端" })

-- python debugger
local dap = require("dap")
local dapui = require("dapui")

-- 设置调试快捷键
vim.keymap.set("n", "<F7>", function()
  dap.continue()
end, { desc = "开始/继续调试" })
vim.keymap.set("n", "<F9>", function()
  dap.step_over()
end, { desc = "单步跳过" })
vim.keymap.set("n", "<F11>", function()
  dap.step_into()
end, { desc = "单步进入" })
vim.keymap.set("n", "<F12>", function()
  dap.step_out()
end, { desc = "跳出函数" })
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "切换断点" })
vim.keymap.set("n", "<leader>dc", function()
  dap.clear_breakpoints()
end, { desc = "清除所有断点" })
vim.keymap.set("n", "<leader>dr", function()
  dap.repl.open()
end, { desc = "打开调试终端" })
vim.keymap.set("n", "<leader>du", function()
  dapui.toggle()
end, { desc = "切换调试 UI" })
