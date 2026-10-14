local function gh(suffix)
	return string.format("https://github.com/%s", suffix)
end

vim.pack.add({
	gh("stevearc/oil.nvim"),
	gh("catppuccin/nvim"),
	gh("neovim/nvim-lspconfig"),
})

vim.cmd.packadd("nvim.undotree")

vim.cmd.colorscheme("catppuccin-mocha")

require("oil").setup({
	keymaps = {
		-- 添加这一行，保留其他默认键位
		["q"] = "actions.close",
		["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-j>"] = false,
    ["<C-k>"] = false,
	},
})

-- - 打开 Oil：文件所在目录；已在 oil 里则往上一级。打开时默认带侧边预览
vim.keymap.set("n", "-", function()
	local oil = require("oil")
	if vim.bo.filetype == "oil" then
		return oil.open()
	end
	oil.open(vim.fn.expand("%:p:h"), { preview = { vertical = true, split = "belowright" } })
end, { noremap = true, silent = true })
