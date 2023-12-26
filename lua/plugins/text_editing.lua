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
        event = "LazyFile",
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
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {
            fast_wrap = {},
        },
    },
    {
        'abecodes/tabout.nvim',
        event = "InsertEnter",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'hrsh7th/nvim-cmp',
        },
        opts = {
            tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
            backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
            act_as_tab = true,            -- shift content if tab out is not possible
            act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
            default_tab = '<C-t>',        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
            default_shift_tab = '<C-d>',  -- reverse shift default action,
            enable_backwards = true,      -- well ...
            completion = true,            -- if the tabkey is used in a completion pum
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = '`', close = '`' },
                { open = '(', close = ')' },
                { open = '[', close = ']' },
                { open = '{', close = '}' }
            },
            ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
            exclude = {} -- tabout will ignore these filetypes
        },
        config = function(_,opts)
            require("tabout").setup(opts)
            -- A multiline tabout setup could look like this
            vim.api.nvim_set_keymap('i', '<A-x>', "<Plug>(TaboutMulti)", {silent = true})
            vim.api.nvim_set_keymap('i', '<A-z>', "<Plug>(TaboutBackMulti)", {silent = true})
        end
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
