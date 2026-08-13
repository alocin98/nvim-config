local treesitter = require("nvim-treesitter")

local ensure_installed = {
    "vimdoc",
    "javascript",
    "typescript",
    "c",
    "lua",
    "rust",
    "markdown",
    "markdown_inline",
}

treesitter.setup()
treesitter.install(ensure_installed)

local highlight_group = vim.api.nvim_create_augroup("alocin98-treesitter-highlight", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = highlight_group,
    pattern = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "markdown" },
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})
