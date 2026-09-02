-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Exit insert mode quickly
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit insert mode" })

-- Centers cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center cursor" })

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TIP: Disable arrow keys in normal mode
-- To force me to use hjkl instaed of arrow keys
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- [[ Git Rebase Keymaps ]]
-- These mappings are only active inside `git rebase -i` buffers.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "gitrebase",
    callback = function()
        local opts = { buffer = true, silent = true }

        local function set_action(action)
            local line = vim.api.nvim_get_current_line()
            local new_line = line:gsub("^%s*%w+", action, 1)
            vim.api.nvim_set_current_line(new_line)
        end

        vim.keymap.set("n", "<leader>e", function()
            set_action("edit")
        end, vim.tbl_extend("force", opts, { desc = "Rebase: edit commit" }))

        vim.keymap.set("n", "<leader>r", function()
            set_action("reword")
        end, vim.tbl_extend("force", opts, { desc = "Rebase: reword commit" }))

        vim.keymap.set("n", "<leader>s", function()
            set_action("squash")
        end, vim.tbl_extend("force", opts, { desc = "Rebase: squash commit" }))

        vim.keymap.set("n", "<leader>f", function()
            set_action("fixup")
        end, vim.tbl_extend("force", opts, { desc = "Rebase: fixup commit" }))

        vim.keymap.set("n", "<leader>p", function()
            set_action("pick")
        end, vim.tbl_extend("force", opts, { desc = "Rebase: pick commit" }))

        vim.keymap.set("n", "<leader>d", function()
            set_action("drop")
        end, vim.tbl_extend("force", opts, { desc = "Rebase: drop commit" }))
    end,
})

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
