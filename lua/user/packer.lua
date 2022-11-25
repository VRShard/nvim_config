local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use 'lewis6991/impatient.nvim'
    use({ "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end
    })
    use "windwp/nvim-autopairs"
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "numToStr/Comment.nvim"
    use { 'akinsho/bufferline.nvim', branch = "main", requires = 'nvim-tree/nvim-web-devicons' }
    use "moll/vim-bbye"
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use 'antoinemadec/FixCursorHold.nvim'
    use { 'rmagatti/auto-session', }
    use {
        'rmagatti/session-lens',
        requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        config = function()
            require('session-lens').setup({})
        end
    }
    use { 'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        "narutoxy/silicon.lua",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require('silicon').setup({
                font = "IBM Plex Mono",
                debug = true,
                theme = "material",
                lineNumber = false,
            })
        end
    }

    use { "sainnhe/everforest" }
    use 'marko-cerovac/material.nvim'
    use 'Luxed/ayu-vim'
    --use "Shatur/neovim-ayu"
    --[[ use({ "EdenEast/nightfox.nvim", ]]
    --[[     config = function() ]]
    --[[         require('nightfox').setup({ ]]
    --[[             options = { ]]
    --[[                 dim_inactive = true, ]]
    --[[                 styles = { -- Style to be applied to different syntax groups ]]
    --[[                     comments = "italic", -- Value is any valid attr-list value `:help attr-list` ]]
    --[[                     conditionals = "bold", ]]
    --[[                     constants = "bold", ]]
    --[[                     functions = "NONE", ]]
    --[[                     keywords = "bold,italic", ]]
    --[[                     numbers = "NONE", ]]
    --[[                     operators = "bold", ]]
    --[[                     strings = "bold,italic", ]]
    --[[                     types = "NONE", ]]
    --[[                     variables = "NONE", ]]
    --[[                 }, ]]
    --[[                 inverse = { -- Inverse highlight for different types ]]
    --[[                     match_paren = true, ]]
    --[[                     visual = false, ]]
    --[[                     search = false, ]]
    --[[                 }, ]]
    --[[             }, ]]
    --[[             palettes = { ]]
    --[[                 dawnfox = { ]]
    --[[                     bg1 = "#f4f6f6", ]]
    --[[                     fg1 = "#005661", ]]
    --[[                 } ]]
    --[[             }, ]]
    --[[             groups = { ]]
    --[[                 dawnfox = { ]]
    --[[                     ["@something"] = { ]]
    --[[                         style = "bold" ]]
    --[[                     } ]]
    --[[]]
    --[[                 } ]]
    --[[             } ]]
    --[[         }) ]]
    --[[     end, ]]
    --[[ }) ]]

    -- use "ggandor/lightspeed.nvim"
    use { "ggandor/leap.nvim",
        config = function() require("leap").set_default_keymaps() end
    }

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    --use 'nvim-lua/lsp_extensions.nvim'
    use { 'simrat39/rust-tools.nvim', branch = "master" }
    --[[ use "williamboman/nvim-lsp-installer" -- simple to use language server installer ]]
    use "williamboman/mason.nvim" -- simple to use language server installer
    -- use "jose-elias-alvarez/null-ls.nvim"
    --[[ use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", ]]
    --[[     config = function() ]]
    --[[         require("lsp_lines").setup() ]]
    --[[     end, ]]
    --[[ }) ]]
    -- cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- snip
    --use 'hrsh7th/cmp-vsnip'
    --use 'hrsh7th/vim-vsnip'
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
    use 'hrsh7th/cmp-nvim-lua'

    --use { "nvim-telescope/telescope-file-browser.nvim" }
    use { 'nvim-tree/nvim-web-devicons', config = function()
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
                };
            }
        end
    end }
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" } -- Tree-sitter
    --[[ use { 'nvim-treesitter/nvim-treesitter-context' } -- Tree-sitter ]]
    use "p00f/nvim-ts-rainbow"
    use 'nvim-treesitter/playground'
    use "JoosepAlviste/nvim-ts-context-commentstring"

    use "lukas-reineke/indent-blankline.nvim"

    use { 'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use "nvim-lua/lsp-status.nvim"
    --use "arkav/lualine-lsp-progress"
    use({ "glepnir/lspsaga.nvim",
        branch = "main",
    })
    use({ "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    })

    use { 'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icon
        },
    }

    use { "akinsho/toggleterm.nvim", branch = "main" }
    use "folke/which-key.nvim"

    use { 'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true, -- shift content if tab out is not possible
                act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                enable_backwards = true, -- well ...
                completion = true, -- if the tabkey is used in a completion pum
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' },
                    { open = '<', close = '>' },
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        wants = { 'nvim-treesitter' }, -- or require if not used so far
        after = { 'cmp-nvim-lua' } -- if a completion plugin is using tabs load it before
    }

    use { "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }

    use { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    --[[ use { 'simrat39/symbols-outline.nvim', ]]
    --[[     config = function() require("symbols-outline").setup() end ]]
    --[[ } ]]

    use "f-person/auto-dark-mode.nvim"

    use "dstein64/vim-startuptime"
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("user.packer").sync()
    end
end)
