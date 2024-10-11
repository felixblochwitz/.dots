return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
		})

		-- some mappoings and a custom function for perfect behavior
		vim.api.nvim_set_keymap("n", "<Leader>nt", ":NvimTreeToggle<CR>", {})

		--- funcion that runs the command ":NvimTreeFocus" if the editor is focussed
		--  and runs the command ":wincmd p" if NvimTree is focussed
		function MyNvimTreeFocus()
			local current_buf = vim.api.nvim_get_current_buf()
			-- TODO: find replacement for deprecated method
			local filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")

			if filetype == "NvimTree" then
				vim.api.nvim_command(":wincmd p")
			else
				vim.api.nvim_command(":NvimTreeFocus")
			end
		end

		vim.api.nvim_set_keymap("n", "<Leader>nf", "<cmd>lua MyNvimTreeFocus()<CR>", {})
	end,
}
