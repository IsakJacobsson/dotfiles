-- List of plugins to install

vim.pack.add({
    "https://github.com/numToStr/Comment.nvim",

    "https://github.com/lewis6991/gitsigns.nvim",

    -- Completion
    "https://github.com/folke/lazydev.nvim",
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
        version = vim.version.range("2.*"),
    },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*"),
    },

    -- Formatting
    "https://github.com/stevearc/conform.nvim",

    "https://github.com/brenoprata10/nvim-highlight-colors",

    -- LSP
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/neovim/nvim-lspconfig",

    -- Oil file manager
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.icons",

    -- Mini
    "https://github.com/echasnovski/mini.nvim",

    -- Telescope
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- Theme
    "https://github.com/folke/tokyonight.nvim",

    -- Treesitter
    "https://github.com/nvim-treesitter/nvim-treesitter",

    -- Undotree
    "https://github.com/mbbill/undotree",
})

