-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- H/L：行内最左/最右的非空白字符（替代窗口顶部/底部）
local map = vim.keymap.set
map({ "n", "v", "o" }, "H", "^", { desc = "First non-blank" })
map({ "n", "v", "o" }, "L", "g_", { desc = "Last non-blank" })

-- <leader>k 和 <leader>h 查看 LSP 悬浮信息；K 用于半屏上移
local function hover()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/hover" }) > 0 then
    vim.lsp.buf.hover()
  end
end

map("n", "<leader>k", hover, { desc = "LSP Hover" })

-- 大写 J/K：半屏下/上滚动，不做 zz 居中，依赖 scrolloff = 3 留边
map({ "n", "v" }, "J", "<C-d>", { desc = "Half page down" })
map({ "n", "v" }, "K", "<C-u>", { desc = "Half page up" })

-- LazyVim 的 LSP K=hover 由 lua/plugins/lsp.lua 禁用，K 使用上面的全局半屏上移
