-- Autocommand that reloads neovim whenever you save the keymaps.lua file
--vim.cmd [[
--  augroup keymap_user_config
--    autocmd!
--    autocmd BufWritePost keymaps.lua source <afile>
--  augroup end
--]]
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local cmd_opts = { expr = true, noremap = true }

local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-Left>", ":tabprevious<CR>", opts)
keymap("n", "<C-Right>", ":tabnext<CR>", opts)

-- keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<C-A-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-A-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope --
-- file browser
--keymap("n","<space>fb","<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",opts)
-- keymap("n", "<space>f", "<cmd>Telescope find_files<CR>", opts)

-- Command --
-- return key wild menu
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.detect_wildmenu_cmd()
    return vim.fn.wildmenumode() == 1 and t '<Down>' or t '<CR>'
end

keymap("c", "<CR>", "v:lua.detect_wildmenu_cmd()", cmd_opts)
