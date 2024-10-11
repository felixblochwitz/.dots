return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>fn", function()
      require("telescope.builtin").find_files({
        cwd = "~/Documents/obsidian",
        prompt_title = "Find Notes",
      })
    end, { noremap = true, silent = true })
    extensions_list = { "themes", "terms" }
  end,
}
