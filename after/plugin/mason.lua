require("mason").setup()



local handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.

    -- Next, you can provide targeted overrides for specific servers.
    ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
    ["tailwindcss"] = function()
        require("lspconfig").tailwindcss.setup {
            cmd = { "tailwindcss-language-server", "--stdio" },
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "Handlebars", "hbs" },
            root_dir = require("lspconfig.util").root_pattern("tailwind.config.js", "package.json"),
            includeLanguages = { hbs = "html" },
            settings = {},
        }
    end,
}

-- alt 1. Either pass handlers when setting up mason-lspconfig:
require("mason-lspconfig").setup({ handlers = handlers })


-- Null-ls setup
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
    },
    -- Autoformat on save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
