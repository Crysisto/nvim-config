local M = {}

local base = {
  -- surfaces
  bg = "#000000",
  bg1 = "#0a0a0a",
  bg2 = "#141414",
  bg3 = "#202020",
  -- lines and borders
  border = "#2e2e2e",
  line = "#444444",
  -- text tiers, darkest to brightest
  comment = "#6a6a6a",
  dim = "#8c8c8c",
  mid = "#b0b0b0",
  fg = "#d8d8d8",
  bright = "#ffffff",
  -- diagnostics (the only hues in the "muted" variant)
  err = "#c25b5b",
  warn = "#b39a62",
}

M.variants = {
  -- accent falls back to bright white, so highlights look the same as plain greyscale
  muted = vim.tbl_extend("force", base, { accent = base.bright }),
  -- one subtle accent colour; change this hex to taste
  accent = vim.tbl_extend("force", base, { accent = "#8fb8c9" }),
}

M.order = { "muted", "accent" }

return M
