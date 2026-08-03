local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Diagnostics are not exclusive to LSP servers, so these mappings are global.
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end)

local lsp_group = vim.api.nvim_create_augroup("LspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>b", function()
            require("conform").format({ bufnr = event.buf, async = true, lsp_format = "fallback" })
        end, opts)
    end,
})

-- Completion capabilities apply to every server loaded through vim.lsp.config.
vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.config("tailwindcss", {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "handlebars",
        "hbs",
        "heex",
        "ex",
        "elixir",
        "eruby",
    },
    root_markers = {
        "tailwind.config.js",
        "tailwind.config.cjs",
        "postcss.config.js",
        "mix.exs",
        "app/assets/tailwind/application.css",
    },
    settings = {
        tailwindCSS = {
            includeLanguages = {
                hbs = "html",
                heex = "html",
                elixir = "html",
                eruby = "html",
            },
            experimental = {
                classRegex = {
                    'class: "(.*?)"',
                    'class= "(.*?)"',
                    '~H""".*class="(.*?)".*"""',
                },
            },
        },
    },
})

vim.lsp.config("rubocop", {
    cmd = { "bundle", "exec", "rubocop", "--lsp" },
    filetypes = { "ruby" },
    root_markers = { "Gemfile" },
})

vim.lsp.config("expert", {
    cmd = { "expert" },
    root_markers = { "mix.exs", ".git" },
    filetypes = { "elixir", "eelixir", "heex" },
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {},
    automatic_enable = true,
})
require("mason-tool-installer").setup({
    ensure_installed = { "prettier" },
    run_on_start = true,
    start_delay = 3000,
    debounce_hours = 24,
})

-- Expert is installed outside Mason and therefore must be enabled explicitly.
vim.lsp.enable("expert")

local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
})
