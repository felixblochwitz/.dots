return {
  {
    "andymass/vim-matchup",
    event = "BufReadPre",  -- Load the plugin when a buffer is read
    config = function()
      vim.g.matchup_matchparen_enabled = 1
      vim.g.matchup_matchparen_deferred = 1  -- Defer highlighting for performance
      vim.g.matchup_matchparen_hi_surround_always = 0  -- Only highlight the current tag
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }  -- Show matching tag in a popup if offscreen

      -- Disable matchup features you don't need
      vim.g.matchup_motion_enabled = 0  -- Disable motion matching
      vim.g.matchup_surround_enabled = 0  -- Disable surround matching
      vim.g.matchup_transmute_enabled = 0  -- Disable transmute functionality
      vim.g.matchup_matchparen_fallback = 0  -- Disable fallback to other matchparen methods
    end
  }
}

