return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = { show_hidden = true },
      keymaps = {
        ["q"] = "actions.close",
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
      },
    },
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open parent directory",
      },
    },
  },
}
