-- recommended setting for tabs from the documentation
-- https://neovim.io/doc/user/options.html#'tabstop'
-- Setting these to 2 seems to solve my issue with different
-- indentation per file type
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

--vim.cmd("colorscheme horizon")

-- TODO: figure out where to best put these
vim.keymap.set({ "n", "v" }, "gd", vim.lsp.buf.definition)
vim.keymap.set({ "n", "v" }, "gr", "<cmd> Telescope lsp_references<cr>")
vim.keymap.set({ "n", "v" }, "gI", vim.lsp.buf.implementation)
vim.keymap.set({ "n", "v" }, "gY", vim.lsp.buf.type_definition)
vim.keymap.set({ "n", "v" }, "gD", vim.lsp.buf.declaration)
vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover)
vim.keymap.set({ "n", "v" }, "gK", vim.lsp.buf.signature_help)
vim.keymap.set({ "i" }, "<c-k>", vim.lsp.buf.signature_help)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run)
vim.keymap.set({ "n", "v" }, "<leader>cC", vim.lsp.codelens.refresh)
vim.keymap.set({ "n" }, "<leader>cf", vim.lsp.buf.format)
vim.keymap.set({ "n" }, "<leader>cr", vim.lsp.buf.rename)

-- the keymaps below are from LazyVim, don't know if I'll need them, but I don't want to delete yet
-- vim.keymap.set({"n", "v"}, "<leader>cr", vim.lsp.codelens.rename)
-- { "<leader>cR", LazyVim.lsp.rename_file, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } }, TODO: checkout if I can imlement this
-- { "<leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" }, TODO: checkout if I want to implement this
--

-- line numbners and relative line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- keeps a fat cursor
vim.opt.guicursor = ""

-- don't know if this does much
vim.opt.smartindent = true

-- text wrapping
vim.opt.wrap = true

-- always show the sign column, otherwise it would shift the text each time
-- a sign is displayed (e.g. errors, warnings etc)
vim.opt.signcolumn = "yes"

-- more sane splitting optiuns
vim.opt.splitright = true
vim.opt.splitbelow = true

-- true colors
vim.opt.termguicolors = true

-- get nice stuff in markdown for obsidian plugin
vim.opt.conceallevel = 1

-- map scrolling to <c-j> and <c-k> to be able to scroll past end of file
-- scroll down
vim.keymap.set({ "n" }, "<c-n>", "<c-e>")
-- scroll up
vim.keymap.set({ "n" }, "<c-m>", "<c-y>")
-- changed it, because it was interfering with my tmux config
