return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "stylua",
            "pyright",
            "bashls",
            "clangd",
        },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = {
                ensure_installed = {
                    "isort",
                    "black",
                },
            },
        },
        "neovim/nvim-lspconfig",
    },
}
