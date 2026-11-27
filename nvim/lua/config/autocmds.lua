-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Match the space outside the terminal grid to the active colorscheme.
if vim.fn.has("win32") == 1 and vim.api.nvim_ui_send then
  local group = vim.api.nvim_create_augroup("terminal_background", { clear = true })
  local background_changed = false

  local function reset_terminal_background()
    if background_changed then
      vim.api.nvim_ui_send("\027]111\027\\")
      background_changed = false
    end
  end

  local function sync_terminal_background()
    local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
    if bg then
      vim.api.nvim_ui_send(("\027]11;#%06x\027\\"):format(bg))
      background_changed = true
    else
      reset_terminal_background()
    end
  end

  vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    group = group,
    callback = sync_terminal_background,
  })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = reset_terminal_background,
  })
  sync_terminal_background()
end
