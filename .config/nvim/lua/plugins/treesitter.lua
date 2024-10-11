return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = { "html" } },
        ensure_installed = {
          "python",
          "javascript",
          "lua",
          "luadoc",
          "luap",
          "c",
          "css",
          "html",
          "scala",
          "markdown",
          "markdown_inline",
        },
      })
    end,
  },
}
