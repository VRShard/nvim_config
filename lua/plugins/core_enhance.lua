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
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim', -- file finding
        },
        -- event = "VeryLazy",
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    {
        'simnalamburt/vim-mundo', -- persistent local file history
        cmd = "MundoToggle",
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        init = function()
            vim.cmd([[nnoremap \ :Neotree toggle<cr>]])
        end,
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
        event = "LazyFile",
        config = function()
            require('gitsigns').setup()
        end,
    },
    {
        'sindrets/diffview.nvim',
        -- event = "UIEnter",
        cmd = "DiffviewToggle",
        config = function()
            require("user.configs.diffview")
        end
    },
    {
        'nvim-treesitter/nvim-treesitter', -- Tree-sitter
        event = { "LazyFile", "VeryLazy" },
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        build = ":TSUpdate",
        config = function()
            require("user.configs.treesitter")
        end
    },
    {
        'nvim-treesitter/playground'
    },
    { 
        'echasnovski/mini.align', 
        version = '*',
        event = { "LazyFile", "VeryLazy" },
        config = function()
            -- No need to copy this inside `setup()`. Will be used automatically.
            require("mini.align").setup {
                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    start = '<leader>ta',
                    start_with_preview = '<leader>tA',
                },

                -- Modifiers changing alignment steps and/or options
                -- modifiers = {
                --     -- Main option modifiers
                --     ['s'] = --<function: enter split pattern>,
                --         ['j'] = --<function: choose justify side>,
                --         ['m'] = --<function: enter merge delimiter>,
                --
                --         -- Modifiers adding pre-steps
                --         ['f'] = --<function: filter parts by entering Lua expression>,
                --         ['i'] = --<function: ignore some split matches>,
                --         ['p'] = --<function: pair parts>,
                --         ['t'] = --<function: trim parts>,
                --
                --         -- Delete some last pre-step
                --         ['<BS>'] = --<function: delete some last pre-step>,
                --
                --         -- Special configurations for common splits
                --         ['='] = --<function: enhanced setup for '='>,
                --         [','] = --<function: enhanced setup for ','>,
                --         [' '] = --<function: enhanced setup for ' '>,
                -- },

                -- Default options controlling alignment process
                options = {
                    split_pattern = '',
                    justify_side = 'left',
                    merge_delimiter = '',
                },

                -- Default steps performing alignment (if `nil`, default is used)
                steps = {
                    pre_split = {},
                    split = nil,
                    pre_justify = {},
                    justify = nil,
                    pre_merge = {},
                    merge = nil,
                },

                -- Whether to disable showing non-error feedback
                silent = false,
            }
        end
    },
    {
        'nvimdev/dashboard-nvim',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
        -- event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                        {
                            icon = ' ',
                            icon_hl = '@variable',
                            desc = 'Files',
                            group = 'Label',
                            action = 'Telescope find_files',
                            key = 'f',
                        },
                        {
                            desc = ' Apps',
                            group = 'Directory',
                            action = 'Telescope app',
                            key = 'a',
                        },
                        {
                            desc = ' dotfiles',
                            group = 'Number',
                            action = 'Telescope dotfiles',
                            key = 'd',
                        },
                    },
                },
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = false,
                },
            }
        end,
    }
}
