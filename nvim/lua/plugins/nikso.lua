return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "soft", -- "soft" | "medium" | "hard"，背景硬度
      })
    end,
  },
  {
    -- 交给 LazyVim 应用配色，避免启动时先加载再丢弃 tokyonight
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.o.background = "light" -- "dark" 为深色
        vim.cmd.colorscheme("everforest")
      end,
    },
  },
}
