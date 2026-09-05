vim.pack.add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.icons",
})

require("oil").setup({
    default_file_explorer = true,

    columns = {},

    view_options = {
        show_hidden = true,
    },
})

-- Open Oil with <leader>e
vim.keymap.set("n", "<leader>e", function()
    require("oil").open()
end, { desc = "Open Oil file explorer" })
