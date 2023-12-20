return {
    {
        'akinsho/bufferline.nvim', -- buffer status for better visibility
        branch = "main",
        event = "VeryLazy",
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
            "sainnhe/gruvbox-material",
        },
        config = function()
            require("user.configs.bufferline")
        end
    },
    {
        'nvim-lualine/lualine.nvim', -- status line
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
            "sainnhe/gruvbox-material",
            opt = true
        },
        event = "VeryLazy",
        config = function()
            require("user.configs.lualine_config")
        end
    },

    {
        'nvim-telescope/telescope.nvim', -- file finding
        cmd = "Telescope",
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require("user.configs.telescope")
        end
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    {
        'simnalamburt/vim-mundo', -- persistent local file history
        cmd = "MundoToggle",
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("user.configs.neotree_config")
        end
    },
    {
        "akinsho/toggleterm.nvim", -- terminal toggle
        branch = "main",
        event = "VeryLazy",
        config = function()
            require("user.configs.toggleterm")
        end
    },
    {
        "folke/which-key.nvim", -- key combo, perhaps can try `Hydra`
        event = "VeryLazy",
        config = function()
            require("user.configs.whichkey")
        end,
    },
    {
        "moll/vim-bbye",
        cmd = "Bdelete",
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        'sindrets/diffview.nvim',
        -- event = "UIEnter",
        cmd = "DiffviewToggle",
        config = function ()
            require("user.configs.diffview")
        end
    },
    { 
        'nvim-treesitter/nvim-treesitter', -- Tree-sitter
        event = { "LazyFile", "VeryLazy" },
        build = ":TSUpdate",
        config = function()
            require("user.configs.treesitter")
        end
    },
    {
        'nvim-treesitter/playground'
    },
}
