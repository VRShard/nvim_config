return {
    {
        "folke/lazy.nvim" -- Have packer manage itself
    },
    {
        "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
    },
    {
        'nvim-tree/nvim-web-devicons', -- icons support, and modified config for some experiments
        config = function()
            local _devicons = require 'nvim-web-devicons'
            if _devicons.has_loaded() then
                _devicons.set_icon {
                    scm = {
                        icon = "ƛ",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Scheme"
                    }
                }
            else
                _devicons.setup {
                    override = {
                        scm = {
                            icon = "ƛ",
                            color = "#428850",
                            cterm_color = "65",
                            name = "Scheme"
                        }
                    },
                }
            end
        end
    },
    {
        "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    },
    -- {
    --     "mini.animate"
    -- },   -- perhaps can be used, sweet for eyes
    {
        "rcarriga/nvim-notify", -- notification API to monitor messages from any arbitary place
        event = "VeryLazy",
        config = function()
            vim.notify = require("notify")
        end
    },
}
