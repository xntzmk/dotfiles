return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        terminal_colors = true,
      },
    },
    config = function(_, opts)
      require("github-theme").setup(opts)
    end,
  },
  { "sainnhe/everforest", lazy = true },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.o.background = "light"
        vim.cmd.colorscheme("everforest")
      end,
    },
  },
}
