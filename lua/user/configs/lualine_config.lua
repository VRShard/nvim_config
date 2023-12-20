local lualine_config = require("lualine")
lualine_config.setup(
    {
        options = {
            icons_enabled = true,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = { "Outline", "toggleterm", "lspsagaoutline" },
            always_divide_middle = true,
            globalstatus = true,
            theme = "gruvbox-material"
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                { 'filename' },
                {
                    function()
                        return require 'lsp-status'.status()
                    end, --fmt=truc(120, 20, 60)
                }
            },
            lualine_x = {
                {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = { fg = "#ff9e64" },
                },
                'encoding',
                'fileformat',
                'filetype'
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
    }
)
