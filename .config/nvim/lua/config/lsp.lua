vim.lsp.enable({
    "bashls",
    "clangd",
    "lua_ls",
    "pyright",
})

-- Configure LSP-specific behavior when an LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),

    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
            return
        end

        -- LSP keymaps
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, {
                buffer = event.buf,
                desc = "LSP: " .. desc,
            })
        end

        -- Use telescope instead of...
        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

        -- Highlight references under the cursor
        if client:supports_method("textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("lsp-highlight", {
                clear = false,
            })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = group,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = group,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- Toggle inlay hints
        if client:supports_method("textDocument/inlayHint") then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(
                    not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                )
            end, "Toggle inlay hints")
        end
    end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = false,
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    } or {},
    virtual_text = {
        current_line = true,
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
})
