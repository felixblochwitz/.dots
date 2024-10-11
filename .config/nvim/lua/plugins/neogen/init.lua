return {
    "danymat/neogen",
    config = function()
        local annotation = require("plugins.neogen.my_google_docstrings")
        require("neogen").setup {
            languages = {
                python = {
                    template = {
                        annotation_convention = "my_google_docstrings",
                        my_google_docstrings = annotation
                    }
                }
            },
            vim.api.nvim_set_keymap("n", "<leader>ds", ":Neogen", {})
        }
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}
