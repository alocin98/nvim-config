require("mason").setup()
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd
    }
})

vim.filetype.add({
    extension = { templ = "templ" }
})
