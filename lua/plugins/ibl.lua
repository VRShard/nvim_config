vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↵")

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

return {
    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        event ={ "LazyFile" },
        dependencies = {
            "sainnhe/gruvbox-material",
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            -- require('rainbow-delimiters.setup').setup { highlight = highlight }
            vim.g.rainbow_delimiters = { highlight = highlight }
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = {
            "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        },
        event ={ "LazyFile" },
        main = "ibl",
        opts = {
            -- space_char_blankline = " ",
            -- show_current_context = true,
            -- show_current_context_start = true,
            -- use_treesitter = true,
            -- use_treesitter_scope = true,
            -- filetype_exclude = { 'NvimTree', 'mason', "packer" },
            -- buftype_exclude = { "terminal", "nofile" },
            ----------------------------------------------------
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                injected_languages = true,
                highlight = "LineNr",
                priority = 1024,
                include = {
                    node_type = {
                        ["*"] = { "*" },
                    },
                },
            },
            exclude = {
                filetypes = { 'neo-tree', 'mason', "packer" },
                buftypes = { "terminal", "nofile" },
            }
        },
        config = function()
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            require("ibl").setup { scope = { highlight = highlight } }

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    }
}
