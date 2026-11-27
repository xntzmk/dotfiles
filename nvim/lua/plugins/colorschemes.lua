return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = true,
    opts = {
      options = {
        -- Windows 清理临时目录时可能留下编译标记，让插件跳过缺失文件。
        compile_path = vim.fn.has("win32") == 1 and vim.fs.joinpath(vim.fn.stdpath("data"), "github-theme") or nil,
      },
    },
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = true,
    config = function()
      require("everforest").setup({
        background = "medium", -- "soft" | "medium" | "hard"，背景硬度
      })
    end,
  },
  {
    -- 交给 LazyVim 应用配色，避免启动时先加载再丢弃 tokyonight
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_light_default",
    },
  },
}
