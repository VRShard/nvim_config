local status_ok, lualine_config = pcall(require, "lualine")
if not status_ok then
    return
end

lualine_config.setup {
    options = {
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { "Outline", "toggleterm", "lspsagaoutline" },
        always_divide_middle = true,
        globalstatus = true,
        theme = "gruvbox"
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            { 'filename' },
            --{"lsp_progress",
            --    display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
            --    separators = {
            --      component = ' ',
            --      progress = ' | ',
            --      percentage = { pre = '', post = '%% ' },
            --      title = { pre = '', post = ': ' },
            --      lsp_client_name = { pre = '[', post = ']' },
            --      spinner = { pre = '', post = '' },
            --      message = { commenced = 'In Progress', completed = 'Completed' },
            --    },
            --    spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
            --}
            {
                function()
                    --vim.g.trunc=function(trunc_width, trunc_len, hide_width, no_ellipsis)
                    --  return function(str)
                    --    local win_width = vim.fn.winwidth(0)
                    --    if hide_width and win_width < hide_width then return ''
                    --    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
                    --       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
                    --    end
                    --    return str
                    --  end
                    --end
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
