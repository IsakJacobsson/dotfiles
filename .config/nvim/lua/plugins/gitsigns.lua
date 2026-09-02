-- See `:help gitsigns` to understand what the configuration keys do
return {
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Gitsigns: " .. desc })
                end

                -- Navigation
                map(']c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                  else
                    gitsigns.nav_hunk('next')
                  end
                end, "Next hunk")

                map('[c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                  else
                    gitsigns.nav_hunk('prev')
                  end
                end, "Previous hunk")

                map("<leader>gs", gitsigns.stage_hunk, "Stage hunk")
                map("<leader>gr", gitsigns.reset_hunk, "Reset hunk")
                map("<leader>gp", gitsigns.preview_hunk, "Preview hunk")
                map("<leader>gi", gitsigns.preview_hunk_inline, "Preview hunk inline")
                map("<leader>gb", function()
                    gitsigns.blame_line({ full = true })
                end, "Blame current line")
                map("<leader>tb", gitsigns.toggle_current_line_blame, "Toggle line blame")
            end,
        },
    },
}
