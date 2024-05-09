require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        indent_width = 1,
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },

    },
    filters = {
        dotfiles = false,
    },
    update_focused_file = {
        enable = true,
        update_root = true,

    },


})


vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")
