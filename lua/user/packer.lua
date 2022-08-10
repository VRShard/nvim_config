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
    use "windwp/nvim-autopairs"
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "numToStr/Comment.nvim"
    use { 'akinsho/bufferline.nvim', branch = "main", requires = 'kyazdani42/nvim-web-devicons' }
    use "moll/vim-bbye"
    use "mfussenegger/nvim-dap"
    use 'antoinemadec/FixCursorHold.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { "sainnhe/gruvbox-material" }
    use 'marko-cerovac/material.nvim'
    use 'Luxed/ayu-vim'
    --use "Shatur/neovim-ayu"

    -- use "ggandor/lightspeed.nvim"
    use { "ggandor/leap.nvim",
        config = function() require("leap").set_default_keymaps() end
    }

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    --use 'nvim-lua/lsp_extensions.nvim'
    use { 'simrat39/rust-tools.nvim', branch = "modularize_and_inlay_rewrite" }
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    -- use "jose-elias-alvarez/null-ls.nvim"
    -- use({
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = function()
    --         require("lsp_lines").register_lsp_virtual_lines()
    --     end,
    -- })

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
    use 'kyazdani42/nvim-web-devicons'
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" } -- Tree-sitter
    use "p00f/nvim-ts-rainbow"
    use 'nvim-treesitter/playground'
    use "JoosepAlviste/nvim-ts-context-commentstring"

    use "lukas-reineke/indent-blankline.nvim"

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use "nvim-lua/lsp-status.nvim"
    --use "arkav/lualine-lsp-progress"

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
    }

    use { "akinsho/toggleterm.nvim", branch = "main" }
    use "folke/which-key.nvim"

    use {
        'abecodes/tabout.nvim',
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

    use {
        "luukvbaal/stabilize.nvim",
        config = function() require("stabilize").setup() end
    }

    use 'simrat39/symbols-outline.nvim'

    use "f-person/auto-dark-mode.nvim"

    use "dstein64/vim-startuptime"
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("user.packer").sync()
    end
end)
