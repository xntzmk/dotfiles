return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        search = { case = "sensitive" }, -- 强制区分大小写
        multi_line = false, -- 仅在当前行搜索
      },
    },
  },
}
