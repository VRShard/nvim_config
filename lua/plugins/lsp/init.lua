return {
    {
        "neovim/nvim-lspconfig",       -- enable LSP
        dependencies = {
            "williamboman/mason.nvim", -- simple to use language server installer
            {
                'hrsh7th/cmp-nvim-lua'
            }, -- perhaps should not be here
        },
        event = { "LazyFile" },
        config = function()
            require("user.lsp")
        end
    },
    {
        "williamboman/mason.nvim",           -- simple to use language server installer
        dependencies = {
            'nvim-telescope/telescope-ui-select.nvim',
        },
        cmd = "Mason",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                }
            })
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        config = function()
            require("lsp_signature").setup()
        end
    },
    {
        'hrsh7th/cmp-nvim-lsp'
    },
    {
        "folke/neodev.nvim"
    }, -- perhaps should not be here
    {
        "nvim-lua/lsp-status.nvim"
    }, -- check alternatives
    {
        "glepnir/lspsaga.nvim",
    },
}
