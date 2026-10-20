local M = {}

function M.load(variant)
  -- Drop cached modules so edits to palette/highlights apply on :colorscheme mono
  package.loaded["mono.palette"] = nil
  package.loaded["mono.highlights"] = nil

  local palette = require("mono.palette")
  variant = variant or vim.g.mono_variant or "muted"
  if not palette.variants[variant] then
    variant = "muted"
  end
  local c = palette.variants[variant]

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "mono"
  vim.g.mono_variant = variant

  for group, opts in pairs(require("mono.highlights")(c)) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  vim.api.nvim_create_user_command("MonoToggle", M.toggle, { force = true })
end

-- Cycle to the next variant. Goes through :colorscheme so ColorScheme autocmds
-- (like the kitty border sync) fire too.
function M.toggle()
  local order = require("mono.palette").order
  local current = vim.g.mono_variant or order[1]
  local idx = 1
  for i, name in ipairs(order) do
    if name == current then
      idx = i
    end
  end
  vim.g.mono_variant = order[(idx % #order) + 1]
  vim.cmd.colorscheme("mono")
  vim.notify("mono: " .. vim.g.mono_variant)
end

return M
