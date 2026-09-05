vim.pack.add({
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

require("telescope").setup({
    pickers = {
        find_files = {
            file_ignore_patterns = {
                "node_modules",
                ".git",
                ".venv",
                "__pycache__",
            },
            hidden = true,
        },
    },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {
    desc = "Telescope find files",
})

vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
    desc = "Telescope live grep",
})

vim.keymap.set("n", "<leader>fb", builtin.buffers, {
    desc = "Telescope buffers",
})

vim.keymap.set("n", "<leader>fw", builtin.grep_string, {
    desc = "Telescope search word under cursor",
})

vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", {
    desc = "Telescope keymaps",
})

vim.keymap.set("n", "<leader>fW", function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
end, {
    desc = "Telescope search WORD under cursor",
})
