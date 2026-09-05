-- Better Around/Inside textobjects
require("mini.ai").setup({
    n_lines = 500,
})

-- Simple statusline
local statusline = require("mini.statusline")

statusline.setup({
    use_icons = vim.g.have_nerd_font,
})

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

    return table.concat(names, " ")
end
