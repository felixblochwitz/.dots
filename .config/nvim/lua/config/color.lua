--[[
-- TODO: think about implementing a color scheme background table for the colorschemes
--       for the color schemes that do not provide separate dark and light themes by default
--
-- This is a suggestion from ChatGPT on how to implement this:
-- local scheme_backgrounds = {
--    vscode = "dark",             -- Valid identifier
--    ["vscode-light"] = "light",  -- Key with a hyphen
--    tokyonight = "dark",         -- Valid identifier
--    ["tokyonight-day"] = "light" -- Key with a hyphen
--  }
--]]
local function switch_scheme(theme)
  local scheme_name = theme.args
  vim.cmd("colorscheme " .. scheme_name)
  local file = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/config/colorscheme.txt"
  local w = io.open(file, "w")
  w:write(scheme_name .. "\n")
  w.close()
end

local function set_active_scheme()
  local file = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/config/colorscheme.txt"
  local r = io.open(file, "r")
  local active_scheme = r:read()
  vim.cmd("colorscheme " .. active_scheme)
end

vim.api.nvim_create_user_command("Cs", switch_scheme, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    -- return completion candidates as a list-like table
    local suggestions = {
      "abscs",
      "doom-one",
      "everblush",
      "horizon",
      "kanagawa-dragon",
      "kanagawa-lotus",
      "kanagawa-wave",
      "melange",
      "mellow",
      "obscure",
      "oxocarbon",
      "rose-pine",
      "rose-pine-dawn",
      "rose-pine-main",
      "rose-pine-moon",
      "tokyonight",
      "tokyonight-night",
      "tokyonight-storm",
      "tokyonight-day",
      "NeoSolarized",
      "vscode",
    }
    return suggestions
  end,
})

set_active_scheme()
