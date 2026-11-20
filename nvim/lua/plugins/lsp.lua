return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- 禁用 LazyVim 默认的 K=hover，让全局 K（半屏上移）生效
            { "K", false },
          },
        },
      },
    },
  },
}
