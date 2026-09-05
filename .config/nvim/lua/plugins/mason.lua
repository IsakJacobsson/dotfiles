vim.pack.add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/neovim/nvim-lspconfig",
})

require("mason").setup()

require("mason-tool-installer").setup({
    ensure_installed = {
        "bash-language-server", -- Uses bashls lsp config
        "clangd",
        "lua-language-server", -- Uses lua_ls lsp config
        "pyright",
        "black",
        "isort",
        "stylua",
    },
})
