local lazygit
if vim.fn.has("win32") == 1 then
  -- Lazygit's nvim-remote preset uses POSIX syntax, but Windows runs it with cmd.exe.
  local remote = [[nvim --headless --server "%NVIM%"]]
  lazygit = {
    config = {
      os = {
        edit = "if defined NVIM (" .. remote .. " --remote-tab {{filename}}) else (nvim -- {{filename}})",
        editAtLine = "if defined NVIM ("
          .. remote
          .. " --remote-tab {{filename}} && "
          .. remote
          .. [[ --remote-send ":{{line}}<CR>") else (nvim +{{line}} -- {{filename}})]],
      },
    },
  }
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = lazygit,
      picker = {
        sources = {
          explorer = {
            hidden = true,
            matcher = { fuzzy = true },
          },
        },
      },
    },
  },
}
