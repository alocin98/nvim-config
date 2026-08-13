return {
    -- LSP and completion
    { "neovim/nvim-lspconfig" },
    { "mason-org/mason.nvim" },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    { "hrsh7th/nvim-cmp" },
    {
        "hrsh7th/cmp-nvim-lsp",
        dependencies = { "hrsh7th/nvim-cmp", "neovim/nvim-lspconfig" },
    },
    { "L3MON4D3/LuaSnip" },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
    },
    { "stevearc/conform.nvim" },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    { "axkirillov/easypick.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
    { "axkirillov/telescope-changed-files", dependencies = { "nvim-telescope/telescope.nvim" } },

    -- Harpoon
    { "theprimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Themes and interface
    { "folke/tokyonight.nvim" },
    { "bluz71/vim-nightfly-colors" },
    { "catppuccin/nvim", name = "catppuccin" },
    { "nvim-tree/nvim-web-devicons" },
    { "EdenEast/nightfox.nvim", name = "nightfox" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Search and replace
    { "nvim-pack/nvim-spectre", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Shared Lua utilities
    { "nvim-lua/plenary.nvim" },

    -- Git
    { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "tpope/vim-fugitive" },

    -- Dotenv
    { "tpope/vim-dotenv" },

    -- SQL
    { "tpope/vim-dadbod" },
    { "kristijanhusak/vim-dadbod-ui", dependencies = { "tpope/vim-dadbod" } },
    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-ui" },
    },

    -- Less frequently used tools
    { "folke/trouble.nvim", opts = { icons = false } },
    {
        "theprimeagen/refactoring.nvim",
        dependencies = {
            "lewis6991/async.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    { "mbbill/undotree" },
    { "folke/zen-mode.nvim" },
    { "github/copilot.vim" },
    { "eandrju/cellular-automaton.nvim" },
}
