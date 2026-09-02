return {
    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require("mini.ai").setup({ n_lines = 500 })

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require("mini.statusline")
            -- set use_icons to true if you have a Nerd Font
            statusline.setup({ use_icons = vim.g.have_nerd_font })

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_diff = function()
                return ""
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_diagnostics = function()
                return ""
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_lsp = function()
                return ""
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_fileinfo = function(args)
                -- Return empty if statusline is truncated
                if MiniStatusline.is_truncated(args.trunc_width) then
                    return ""
                end

                -- Get active LSP clients for the current buffer
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if #clients == 0 then
                    return ""
                end

                -- Collect client names
                local names = {}
                for _, client in ipairs(clients) do
                    table.insert(names, client.name)
                end

                -- Return concatenated client names
                return table.concat(names, " ")
            end
        end,
    },
}
