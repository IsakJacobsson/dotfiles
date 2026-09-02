return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
        columns = {},
        view_options = {
            show_hidden = true,
        },
    },
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function(_, opts)
        require("oil").setup(opts)

        -- Open Oil with <leader>e (replaces netrw :Ex)
        vim.keymap.set("n", "<leader>e", function()
            require("oil").open()
        end, { desc = "Open Oil file explorer" })
    end,
}
