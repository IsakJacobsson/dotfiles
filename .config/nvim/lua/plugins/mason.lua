require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "bashls",
        "clangd",
    },
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "stylua",
        "isort",
        "black",
    },
})
