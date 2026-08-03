local conform = require("conform")

local function prettier()
    return { "prettier" }
end
local format_on_save = {
    css = true,
    eelixir = true,
    elixir = true,
    eruby = true,
    heex = true,
    html = true,
    javascript = true,
    javascriptreact = true,
    json = true,
    markdown = true,
    ruby = true,
    scss = true,
    typescript = true,
    typescriptreact = true,
    vue = true,
    yaml = true,
}

conform.setup({
    formatters_by_ft = {
        css = prettier(),
        eelixir = { "mix" },
        elixir = { "mix" },
        eruby = { "erb_format" },
        heex = { "mix" },
        html = prettier(),
        javascript = prettier(),
        javascriptreact = prettier(),
        json = prettier(),
        markdown = prettier(),
        ruby = { lsp_format = "fallback" },
        scss = prettier(),
        typescript = prettier(),
        typescriptreact = prettier(),
        vue = prettier(),
        yaml = prettier(),
    },
    default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 2000,
    },
    format_on_save = function(bufnr)
        if format_on_save[vim.bo[bufnr].filetype] then
            return {
                bufnr = bufnr,
                lsp_format = "fallback",
                timeout_ms = 2000,
            }
        end
    end,
    notify_no_formatters = false,
})
