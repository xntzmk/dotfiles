-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- theniceboy 布局的 QWERTY 版移动键
-- I/J/K/L 倒 T；原来的 i（insert / inside text object）挪到 n
-- 代价：ciw → cnw，di( → dn(，viw → vnw；e/u/l 保持原功能
local map = vim.keymap.set
local move_modes = { "n", "v", "o" } -- v 同时覆盖 visual 和 select

map(move_modes, "i", "k", { desc = "Up" })
map(move_modes, "j", "h", { desc = "Left" })
map(move_modes, "k", "j", { desc = "Down" })
-- l 保持向右，不映射

-- 原 i 的 insert 和 inside text object 都改到 n
map(move_modes, "n", "i", { desc = "Insert / inside text object" })
map("n", "N", "I", { desc = "Insert at line start" })

-- n/N 让位后，搜索跳转改到 = / -
map("n", "=", "n", { desc = "Next match" })
map("n", "-", "N", { desc = "Previous match" })

-- theniceboy 的行首/行尾：物理 Shift+J / Shift+L
-- 代价：J 不再是 join lines，L 不再是屏幕底部
map(move_modes, "J", "0", { desc = "Line start" })
map(move_modes, "L", "$", { desc = "Line end" })

-- 窗口切换：物理 Ctrl+I/J/K/L = 上/左/下/右
-- 注意 <C-i> 在终端里等同 Tab，会覆盖 normal 模式下的 jumplist forward
map("n", "<C-i>", "<C-w>k", { desc = "Window up" })
map("n", "<C-j>", "<C-w>h", { desc = "Window left" })
map("n", "<C-k>", "<C-w>j", { desc = "Window down" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
