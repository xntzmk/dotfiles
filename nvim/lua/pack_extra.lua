local function gh(suffix)
	return string.format("https://github.com/%s", suffix)
end

vim.pack.add({
	gh("nvim-mini/mini.surround"),
})

-- 增删改包围符：sa / sd / sr（另有 sf/sF 查找、sh 高亮）
require("mini.surround").setup({
	custom_surroundings = {
		-- 字母别名：b=圆括号（内置）、B=花括号、r=方括号
		B = { input = { { "%b{}" }, "^.().*().$" }, output = { left = "{", right = "}" } },
		r = { input = { { "%b[]" }, "^.().*().$" }, output = { left = "[", right = "]" } },
	},
})
