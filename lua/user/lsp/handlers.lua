local lsp_status = require('lsp-status')
local M = {}

-- TODO: backfill this to template
M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- disable virtual text
        virtual_text = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

local function lsp_highlight_document(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
              augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup END
            ]],
            false
        )
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gl",
        '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
    -- vim.api.nvim_buf_set_keymap(bufnr, "", "<leader>ff", "<cmd>:Format<CR>", opts)
end

M.on_attach = function(client, bufnr)
    --if client.name == "tsserver" then
    --  client.resolved_capabilities.document_formatting = false
    --end
    lsp_status.on_attach(client)
    if client.name == "rust_analyzer" then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>:RustHoverActions<CR>", { noremap = true, silent = true })
        vim.cmd [[
              augroup change_inlayHinthand
                autocmd! * <buffer>
                " autocmd CursorHold,CursorHoldI <buffer> lua require("rust-tools.inlay_hints").set_inlay_hints()
                " autocmd CursorHold,CursorHoldI <buffer> lua require("rust-tools.inlay_hints").enable()
                autocmd CursorHold,CursorHoldI <buffer> lua vim.lsp.codelens.refresh()
              augroup END
            ]]
        --[[ client.server_capabilities.semanticTokensProvider = nil ]]
        -- local cb = vim.lsp.handlers["$/progress"]
        -- vim.lsp.handlers["$/progress"] = function(...)
        --     cb(...)
        --     local arg = select(4, ...)
        --     if type(arg) ~= 'number' then
        --         local function init_lens(_, msg, _)
        --             local key = msg.token
        --             local val = msg.value
        --
        --             if key then
        --                 if val then
        --                     if val.kind == 'end' then
        --                         vim.lsp.buf_request(0, "textDocument/codeLens", { textDocument = require("vim.lsp.util").make_text_document_params(0) })
        --                     end
        --                 end
        --             end
        --         end
        --
        --         init_lens(...)
        --     end
        -- end
    end
    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider.legend = {
            tokenModifiers = { "static" },
            tokenTypes = { "comment", "excluded", "identifier", "keyword", "number", "operator",
                "preprocessor", "string", "whitespace", "text", "static", "punctuation",
                "class", "delegate", "enum", "interface", "module", "struct", "typeParameter", "field",
                "enumMember", "constant", "local", "parameter", "method", "property", "event", "namespace",
                "label", "xml", "regexp" }
        }
    end
    --[[ lsp_keymaps(bufnr) ]]
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
