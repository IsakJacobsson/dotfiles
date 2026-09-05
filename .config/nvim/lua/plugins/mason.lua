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
