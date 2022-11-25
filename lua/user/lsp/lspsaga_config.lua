local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
    return
end

saga.init_lsp_saga({
    -- Options with default value
    -- "single" | "double" | "rounded" | "bold" | "plus"
    border_style = "rounded",
    --the range of 0 for fully opaque window (disabled) to 100 for fully
    --transparent background. Values between 0-30 are typically most useful.
    saga_winblend = 20,
    -- when cursor in saga window you config these to move
    move_in_saga = { prev = '<C-p>', next = '<C-n>' },
    -- Error, Warn, Info, Hint
    -- use emoji like
    -- { "🙀", "😿", "😾", "😺" }
    -- or
    -- { "😡", "😥", "😤", "😐" }
    -- and diagnostic_header can be a function type
    -- must return a string and when diagnostic_header
    -- is function type it will have a param `entry`
    -- entry is a table type has these filed
    -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
    diagnostic_header = { " ", " ", " ", "ﴞ " },
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 10,
    -- use emoji lightbulb in default
    code_action_icon = "💡",
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    -- same as nvim-lightbulb but async
    code_action_lightbulb = {
        enable = true,
        enable_in_insert = true,
        cache_code_action = true,
        sign = true,
        update_time = 150,
        sign_priority = 20,
        virtual_text = false,
    },
    -- finder icons
    finder_icons = {
        def = '  ',
        ref = '諭 ',
        link = '  ',
    },
    -- finder do lsp request timeout
    -- if your project big enough or your server very slow
    -- you may need to increase this value
    finder_request_timeout = 1500,
    finder_action_keys = {
        open = "<CR>",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>",
    },
    definition_action_keys = {
        edit = '<C-c>o',
        vsplit = '<C-c>v',
        split = '<C-c>i',
        tabe = '<C-c>t',
        quit = 'q',
    },
    rename_action_quit = "<C-c>",
    rename_in_select = true,
    -- show symbols in winbar must nightly
    symbol_in_winbar = {
        in_custom = false,
        enable = true,
        separator = ' ',
        show_file = true,
        click_support =
        function(node, clicks, button, modifiers)
            -- To see all avaiable details: vim.pretty_print(node)
            local st = node.range.start
            local en = node.range['end']
            if button == "l" then
                if clicks == 2 then
                    -- double left click to do nothing
                else -- jump to node's starting line+char
                    vim.fn.cursor(st.line + 1, st.character + 1)
                end
            elseif button == "r" then
                if modifiers == "s" then
                    print "lspsaga" -- shift right click to print "lspsaga"
                end -- jump to node's ending line+char
                vim.fn.cursor(en.line + 1, en.character + 1)
            elseif button == "m" then
                -- middle click to visual select node
                vim.fn.cursor(st.line + 1, st.character + 1)
                vim.cmd "normal v"
                vim.fn.cursor(en.line + 1, en.character + 1)
            end
        end,
    },
    -- show outline
    show_outline = {
        win_position = 'right',
        --set special filetype win that outline window split.like NvimTree neotree
        -- defx, db_ui
        win_with = '',
        win_width = 30,
        auto_enter = true,
        auto_preview = true,
        virt_text = '┃',
        jump_key = '<CR>',
        -- auto refresh when change buffer
        auto_refresh = true,
    },
    -- custom lsp kind
    -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
    custom_kind = {},
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = { metals = { "sbt", "scala" } }
    server_filetype_map = {},
    -- your configuration
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set --[[ vim.api.nvim_buf_set_keymap ]]
-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- Code action
--[[ keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) ]]

-- Rename
--[[ keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts) ]]

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)

-- Show line diagnostics
keymap("n", "gL", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

-- Show cursor diagnostic
keymap("n", "gl", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Only jump to error
keymap("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymap("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Outline
keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

--[[ -- Float terminal ]]
--[[ keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", opts) ]]
--[[ -- if you want pass somc cli command into terminal you can do like this ]]
--[[ -- open lazygit in lspsaga float terminal ]]
--[[ keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm gitui<CR>", opts) ]]
--[[ -- close floaterm ]]
--[[ keymap("t", "<A-d>", "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>", opts) ]]
