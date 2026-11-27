-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- J/K 半屏滚动时，上下至少保留 3 行
vim.opt.scrolloff = 3

-- 插件管理
vim.g.snacks_scroll = false

-- 隐藏行尾空格的显示标记
vim.opt.listchars:remove("trail")
