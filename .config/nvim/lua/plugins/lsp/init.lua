return {
  -- install mason
  -- basic install so far -> TODO: see if there are any options I might need
  {
    "williamboman/mason.nvim",
    opts = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- install mason lsp-config (for ensure installed)
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "emmet_language_server",
          "html",
          "lua_ls",
          "pyright",
          "ts_ls",
          "clangd",
          "ruff",
        },
      })
    end,
  },

  -- install mason null-ls (for ensure installed)
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function()
      require("mason-null-ls").setup({
        automatic_installation = false,
        ensure_installed = { "black", "clang-format", "djlint", "isort", "prettier", "stylua", "mypy" },
      })
    end,
  },

  -- install nvim-lsp
  -- link to all server configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  -- when I add a language server here, I also need to add it
  -- to /lua/plugins/completion/init.lua (to the list at the bottom)
  {
    "neovim/nvim-lspconfig",
  },

  -- this last large block is for completion
  -- I decided to put this here, because it calls the lspconfig in the end
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end
      local cmp = require("cmp")
      cmp.setup({

        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
              feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
              cmp.complete()
            else
              fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
              feedkey("<Plug>(vsnip-jump-prev)", "")
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              vsnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              cmdline = "[Cmdline]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require("lspconfig")["cssls"].setup({
        capabilities = capabilities,
      })
      require("lspconfig")["emmet_language_server"].setup({
        capabilities = capabilities,
      })
      require("lspconfig")["html"].setup({
        capabilities = capabilities,
      })
      require("lspconfig")["lua_ls"].setup({
        capabilities = capabilities,
      })
      require("lspconfig")["pyright"].setup({
        capabilities = capabilities,
      })
      require("lspconfig")["ruff"].setup({
        init_options = require("plugins.lsp.ruff_settings"),
        capabilities = capabilities,
      })
      require("lspconfig")["ts_ls"].setup({
        capabilities = capabilities,
      })
      require("lspconfig")["clangd"].setup({
        capabilities = capabilities,
      })
    end,
  },
}
