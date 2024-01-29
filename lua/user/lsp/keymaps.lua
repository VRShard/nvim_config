local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- for current buffer only
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
    ["l"] = {
        name = "+LSP",
        a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename" },
        --[[ h = { "<cmd>Lspsaga lsp_finder<CR>", "Lspsaga Finder" }, ]]
        f = { "<cmd>lua vim.lsp.buf.format { async=true }<cr>", "Format" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        d = {
            "<cmd>Telescope diagnostics bufnr=0<cr>",
            "Document Diagnostics",
        },
        w = {
            "<cmd>Telescope diagnostics<cr>",
            "Workspace Diagnostics",
        },
        j = {
            "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
        i = { "<cmd>LspInfo<cr>", "Info" },
        -- I = { "<cmd>Mason<cr>", "Installer Info" },
    },
}

local init_map = {
    ["l"] = { "<cmd>LspStart<cr>", "Start Lsp Server" },
}

local M = {}

M.buf_has_lsp = function ()
    return #vim.lsp.get_clients({bufnr=0}) ~= 0
end

-- bind the LspStart keymap to a new buffer, if Lsp is not running or not attached to this buffer
M.bind_init = function (bufnr)
    local k, v = next(init_map)
    vim.api.nvim_buf_set_keymap(bufnr, "n", opts.prefix .. k, v[1], {noremap = true,nowait = true,desc = "load lsp"})
end

-- bind default lsp config for now
M.bind_default_lsp = function (bufnr)
    local opts2 = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = bufnr, -- for current buffer only
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }
    require("which-key").register(mappings, opts2)
end

-- remove which-key keybinding for LspStart
M.unbind_init = function (bufnr)
    local k,_ = next(init_map)
    local status_ok, _ = pcall(vim.api.nvim_buf_del_keymap, bufnr, "n", opts.prefix .. k)
    -- if not status_ok then
    --     vim.notify("cannot remove lsp start keymap", vim.log.levels.WARN, nil)
    -- end
end

M.create_auto_cmd = function ()
    local load = function(ev)
        if not M.buf_has_lsp() then
            M.bind_init(ev.buf)
            require("which-key").setup()
        end
        vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
    end
    load = vim.schedule_wrap(load)
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePre" }, {
        group = vim.api.nvim_create_augroup("buffer_lsp", { clear = true }),
        callback = function(_ev)
            load(_ev)
        end,
    })
end

return M
