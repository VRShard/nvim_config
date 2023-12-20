return {
    {
        "ggandor/leap.nvim", -- motion flow
        event = "VeryLazy",
        config = function() require("leap").set_default_keymaps() end
    },
    {
        "folke/todo-comments.nvim", -- simple text based TODO mgnt
        -- TODO: modify the event to lazy load also on non-blocking `OnInsertEnter`
        cmd = "TodoTelescope",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "tpope/vim-surround",
        event = "VeryLazy"
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy"
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                opts = {
                    enable_autocmd = false,
                }
            },
        },
        config = function()
            require("user.configs.autocomment")
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {
                'hrsh7th/cmp-buffer'
            },
            {
                'hrsh7th/cmp-path'
            },
            {
                'hrsh7th/cmp-cmdline'
            },
            -- luasnip
            {
                "saadparwaiz1/cmp_luasnip" -- snippet completions
            },
            {
                "L3MON4D3/LuaSnip" --snippet engine
            },
            {
                "rafamadriz/friendly-snippets" -- a bunch of snippets to use
            },
        },
        event = "InsertEnter",
        config = function()
            require("user.configs.cmp")
        end
    },
}
