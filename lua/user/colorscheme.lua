vim.g.material_style = 'lighter'
require('material').setup({

    contrast = {
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        line_numbers = true, -- Enable contrast background for line numbers
        sign_column = true, -- Enable contrast background the sign column
        cursor_line = false, -- Enable darker background for the cursor line
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
        --[[ "indent-blankline", ]]
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
        "terminal", -- Darker terminal background
        "lazy", -- Darker packer background
        "qf", -- Darker qf list background
        "mason",
    },

    high_visibility = {
        lighter = true, -- Enable higher contrast text for lighter style
        darker = true -- Enable higher contrast text for darker style
    },

    disable = {
        colored_cursor = true,
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = true -- Hide the end-of-buffer lines
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
})
--[[ vim.g.everforest_disable_terminal_colors = 1 ]]
--[[ vim.g.everforest_background = 'hard' ]]
local color_theme = "material"
--[[ vim.cmd "colorscheme material" ]]
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. color_theme)
if not status_ok then
    vim.notify("colorscheme " .. color_theme .. " not found!")
    return
end
