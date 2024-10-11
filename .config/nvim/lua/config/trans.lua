---Function to toggle between transparency and opacity
local function toggle_trans()
  local highlight_groups = {
    "Normal",
    "SignColumn",
    "NormalNC",
    "MsgArea",
    "TelescopeBorder",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "EndOfBuffer",
    "NvimTreeEndOfBuffer",
    -- testing new additional groups below
    "LineNr",
    "CursorLineNr",
    "FoldColumn",
    "GitSignsAdd",
    "GitSignsChange",
    "GitSignsDelete",
  }

  local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
  if not normal_bg then
    vim.cmd("colorscheme " .. vim.g.colors_name)
    return
  end
  for _, group in ipairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

vim.keymap.set("n", "<leader>TT", toggle_trans)
