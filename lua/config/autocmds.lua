-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local function send(seq)
  if vim.api.nvim_ui_send then
    vim.api.nvim_ui_send(seq)
  else
    io.stdout:write(seq)
    io.stdout:flush()
  end
end

local function sync_bg()
  local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  if hl.bg then
    send(string.format("\027]11;#%06x\027\\", hl.bg))
  end
end

local function reset_bg()
  send("\027]111\027\\")
end

local group = vim.api.nvim_create_augroup("kitty_bg_sync", { clear = true })

vim.api.nvim_create_autocmd({ "ColorScheme", "VimResume", "FocusGained" }, {
  group = group,
  callback = sync_bg,
})
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  group = group,
  callback = reset_bg,
})

-- Run once now, since this file loads after startup events have fired
vim.schedule(sync_bg)
