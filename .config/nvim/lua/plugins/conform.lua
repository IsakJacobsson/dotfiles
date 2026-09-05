require("conform").setup({
    notify_on_error = false,
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
    },
})

vim.keymap.set("", "<leader>f", function()
    require("conform").format({
        async = true,
        lsp_format = "fallback",
    })
end, { desc = "[F]ormat buffer" })
