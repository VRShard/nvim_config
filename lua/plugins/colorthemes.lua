return {
    {
        'marko-cerovac/material.nvim',
        config = true,
        event = "VeryLazy",
        enabled = true,
        opts = {
            contrast = {
                sidebars = true,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                floating_windows = true,    -- Enable contrast for floating windows
                line_numbers = true,        -- Enable contrast background for line numbers
                sign_column = true,         -- Enable contrast background the sign column
                cursor_line = false,        -- Enable darker background for the cursor line
                non_current_windows = true, -- Enable darker background for non-current windows
                --[[ popup_menu = false, -- Enable lighter background for the popup menu ]]
            },

            styles = {
                comments = { bold = false, italic = true },
                strings = { bold = true, italic = true },
                keywords = { bold = true, italic = false },
                functions = { bold = false, italic = true },
                variables = { bold = false, italic = false },
                operators = { bold = true, italic = false },
                types = { bold = true, italic = false },
            },

            plugins = { -- Uncomment the plugins that you use to highlight them
                -- Available plugins:
                "dap",
                --[[ "dashboard", ]]
                "gitsigns",
                --[[ "hop", ]]
                "indent-blankline",
                "lspsaga",
                --[[ "mini", ]]
                --[[ "neogit", ]]
                "nvim-cmp",
                --[[ "nvim-navic", ]]
                "nvim-tree",
                --[[ "sneak", ]]
                "telescope",
                "trouble",
                "which-key",
            },

            contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
                "terminal",        -- Darker terminal background
                "lazy",            -- Darker packer background
                "qf",              -- Darker qf list background
                "mason",
            },

            high_visibility = {
                lighter = true, -- Enable higher contrast text for lighter style
                darker = true   -- Enable higher contrast text for darker style
            },

            disable = {
                colored_cursor = true,
                borders = false,     -- Disable borders between verticaly split windows
                background = false,  -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
                term_colors = false, -- Prevent the theme from setting terminal colors
                eob_lines = true     -- Hide the end-of-buffer lines
            },

            async_loading = true,

            lualine_style = "default",

            custom_highlights = {
                ["@something"] = {
                    bold = true,
                    italic = false,
                },
                ["Operator"] = {
                    bold = true,
                    italic = false,
                },
                ["MatchParen"] = {
                    bg = "#FFCB6B",
                    bold = true,
                },
                ["NotifyINFOTitle"] = {
                    fg = "#b2d582",
                },
                ["NotifyINFOIcon"] = {
                    fg = "#b2d582",
                },
                ["LspInlayHint"] = {
                    fg = "#d3d3d3",
                },
            } -- Overwrite highlights with your own
        }
    },
    {
        "sainnhe/gruvbox-material",
        event = "VeryLazy",
        config = function()
            vim.g.gruvbox_material_background = 'medium'
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_disable_italic_comment = 0
            vim.g.gruvbox_material_enable_bold = 0
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_transparent_background = 0
            vim.g.gruvbox_material_dim_inactive_windows = 0
            vim.g.gruvbox_material_ui_contrast = 'high'
            vim.g.gruvbox_material_show_eob = 0
            vim.g.gruvbox_material_diagnostic_text_highlight = 0
            vim.g.gruvbox_material_diagnostic_virtual_text = 'grey'
            vim.g.gruvbox_material_current_word = 'bold'
            vim.g.gruvbox_material_better_performance = 1

            -- should move to another place
            local color_theme = "gruvbox-material"
            local status_ok, _ = pcall(vim.cmd, "colorscheme " .. color_theme)
            if not status_ok then
                vim.notify("colorscheme " .. color_theme .. " not found!")
                return
            else
                vim.cmd("set background=dark")
            end
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        enabled = false,
        opts = {
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = true,
            invert_signs = true,
            invert_tabline = true,
            invert_intend_guides = true,
            inverse = true,    -- invert background for search, diffs, statuslines and errors
            contrast = "hard", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {
                ["@something"] = {
                    bold = true,
                    italic = false,
                },
                ["Operator"] = {
                    bold = true,
                    italic = false,
                },
                ["MatchParen"] = {
                    bg = "#FFCB6B",
                    bold = true,
                },
            },
            dim_inactive = true,
            transparent_mode = true,
        }
    },
    { "sainnhe/everforest" },
    {
        'Luxed/ayu-vim'
    },
    {
        'talha-akram/noctis.nvim'
    },
}
