-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        -- these will be buffer-local keybindings
        -- because they only work if you have an active language server

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'vd', '<cmd>lua vim.lsp.buf.<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set('n', '<leader>b', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require("lspconfig")

local default_setup = function(server)
  lspconfig[server].setup({
    capabilities = lsp_capabilities,
  })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        default_setup,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                capabilities = lsp_capabilities,
            })
        end,
        tailwindcss = function()
            require('lspconfig').tailwindcss.setup({
                capabilities = lsp_capabilities,
                cmd = { "tailwindcss-language-server", "--stdio" },
                filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "handlebars", "hbs", "heex" },
                root_dir = require("lspconfig.util").root_pattern("tailwind.config.js", "tailwind.config.cjs", "postcss.config.js", "mix.exs"),
                includeLanguages = { hbs = "html", heex = "html" },
                settings = {
      tailwindCSS = {
        includeLanguages = {
          heex = "html"
        },
        experimental = {
          classRegex = {
            -- Optional: support for dynamic class extraction in Phoenix style
            'class: "(.*?)"',
            'class= "(.*?)"',
            '~H""".*class="(.*?)".*"""'
          }
        }
      }
  }
            })
        end,
       prettierd = function()
            require('lspconfig').prettierd.setup({
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "json", "yaml", "markdown", "jsx", "tsx", "heex", "ex" },
            })
        end,
    }
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Ctrl + space triggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            -- Automatically uses local prettier from node_modules if available
            prefer_local = "node_modules/.bin",
        }),
    },
})

require("mason-null-ls").setup({
    ensure_installed = { "prettierd" },
    automatic_setup = true,
})


vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.js", "*.ts", "*.json", "*.md", "*.css", "*.scss", "*.html", "*.vue", "*.yaml", "*.tsx", "*.heex" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
