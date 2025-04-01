-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use "williamboman/mason.nvim"
    use 'williamboman/mason-lspconfig.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, }
    use("nvim-treesitter/nvim-treesitter-context");
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use("nvimtools/none-ls.nvim");



    -- telescope
    use {'nvim-telescope/telescope.nvim', tag = '0.1.8'}
    use "nvim-telescope/telescope-file-browser.nvim"
    use { 'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim' }
    use { "axkirillov/telescope-changed-files" }

    -- Harpoon
   use("theprimeagen/harpoon")

    -- Themes
    use "folke/tokyonight.nvim"
    use "bluz71/vim-nightfly-colors"
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'nvim-tree/nvim-web-devicons'

    -- Find and replace
    use "nvim-pack/nvim-spectre"
    -- Status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- Filetree viewer
   use {'nvim-tree/nvim-tree.lua'}

    -- polyfills
    use "nvim-lua/plenary.nvim"

    -- Git
    use "sindrets/diffview.nvim"
    use("tpope/vim-fugitive")



    -- not fequently used
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })
    use("theprimeagen/refactoring.nvim")
    use("mbbill/undotree")


    use("folke/zen-mode.nvim")
    use("github/copilot.vim")
    use("eandrju/cellular-automaton.nvim")
end)
