require("options")
require("keymaps")

-- VSCode 里不引入这些插件
if not vim.g.vscode then
	require("pack")
end

require("pack_extra")

-- For VSCode
if vim.g.vscode then
	local vscode = require("vscode")
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "oil",
		callback = function()
			vim.keymap.set("n", "q", function()
				vscode.action("oil-code.close")
			end, { buffer = true })
		end,
	})
	vim.keymap.set("n", "gd", function()
		vscode.action("editor.action.revealDefinition")
	end)
end
