-- 自己的键位（插件相关的键位留在 init.lua）
local keymap = vim.keymap
local keymap_opt = { noremap = true, silent = true }

keymap.set("n", "ss", ":split<cr>", keymap_opt)
keymap.set("n", "sv", ":vsplit<cr>", keymap_opt)

keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

keymap.set("n", "j", "gj", keymap_opt)
keymap.set("n", "k", "gk", keymap_opt)

keymap.set({ "n", "o" }, "H", "^", keymap_opt)
keymap.set({ "n", "o" }, "L", "g_", keymap_opt)

vim.keymap.set("n", "<C-s>", "<cmd>write<CR>", { noremap = true, silent = true, desc = "Save file" })
vim.keymap.set(
	"i",
	"<C-s>",
	"<Esc><cmd>write<CR>a",
	{ noremap = true, silent = true, desc = "Save file in insert mode" }
)
