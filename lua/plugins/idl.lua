vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↵")

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        commit = "9637670",
        -- main = "ibl",
        opts = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
            use_treesitter = true,
            use_treesitter_scope = true,
            filetype_exclude = { 'NvimTree', 'mason', "packer" },
            buftype_exclude = { "terminal", "nofile" },
            -- scope = {
            --     enabled = true,
            --     show_start = true,
            --     show_end = true,
            --     injected_languages = true,
            --     highlight = "LineNr",
            --     priority = 1024,
            --     include = {
            --         node_type = {
            --             ["*"] = { "*" },
            --         },
            --     },
            -- },
            -- exclude = {
            --     filetypes = { 'NvimTree', 'mason', "packer" },
            --     buftypes = { "terminal", "nofile" },
            -- }
        },
    }
}
