return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- 项目若用 Volta 锁了 Node 14，Volar 3 会因 ??= 语法直接崩溃；
      -- 从项目外启动语言服务，让它用全局 Node 20
      local cwd = vim.fn.stdpath("data")
      for _, name in ipairs({ "vue_ls", "vtsls" }) do
        opts.servers[name] = opts.servers[name] or {}
        opts.servers[name].cmd_cwd = cwd
      end
    end,
  },
}
