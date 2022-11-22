-- Filename: keymap.lua-- Filename: keymap.lua
-- Last Change: Tue, 22 Nov 2022 09:46:54
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

-- local function keymap(mode, lhs, rhs, opts)
-- 	local options = { noremap = true, silent = true }
-- 	if opts then
-- 		if opts.desc then
-- 			opts.desc = "init.lua: " .. opts.desc
-- 		end
-- 		options = vim.tbl_extend("force", options, opts)
-- 	end
-- 	vim.keymap.set(mode, lhs, rhs, options)
-- end

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { noremap = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--   modes          key
-- ---------       -----
--  normal           n
--  insert           i
--  visual           v
--  v-block          x
--  term             t
--  command          c

-- remap = to +
keymap("", "=", "+", opts)
keymap("", "+", "=", opts)

-- normal mode
-- █▄ █ ▄▀▄ █▀▄ █▄ ▄█ ▄▀▄ █     █▄ ▄█ ▄▀▄ █▀▄ ██▀
-- █ ▀█ ▀▄▀ █▀▄ █ ▀ █ █▀█ █▄▄   █ ▀ █ ▀▄▀ █▄▀ █▄▄
--

-- source init.lua
keymap("n", "<leader>so", "<CMD>source ~/.config/nvim/init.lua<CR>", term_opts)

-- jump to exact mark
keymap("n", "'", "`", opts)
keymap("n", "`", "'", opts)

-- remap ç to :
keymap("n", "ç", ":", term_opts)
keymap("n", "Ç", ":", term_opts)

-- x dont copy
-- keymap("n", "x", '"_x', opts)

-- remove highlights
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- paste the last thing that was yanked, not deleted
keymap("n", ",p", '"0p', opts)
keymap("n", ",P", '"0P', opts)

-- increment / decrement
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)

-- select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- delete backwars
keymap("n", "db", 'vb"_d', opts)

-- quick save
keymap("n", "<leader>w", ":up<CR>", opts) -- save file only if there are changes
-- keymap("n", "<leader>q", ":wq<CR>", opts)
keymap("n", "<leader>q", "ZZ", opts)
keymap("n", "<leader>dq", "ZQ", opts)

-- split window
keymap("n", "<leader>sv", "<C-w>v", opts)
keymap("n", "<leader>sh", "<C-w>s", opts)
-- keymap("n", "<leader>se", "<C-w>e", opts)
keymap("n", "<leader>sx", ":close<CR>", opts)

keymap("n", "<leader>stv", ":verticalsplit term://zsh<CR>clear<CR>", opts)
keymap("n", "<leader>sth", ":split term://zsh<CR>clear<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-DOWN>", ":resize -2<CR>", opts)
keymap("n", "<C-UP>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>", opts)

-- copy current line above and bellow
keymap("n", "<A-J>", "mzyyp`zj", opts)
keymap("n", "<A-K>", "mzyyP`zk", opts)

-- insert mode
-- █ █▄ █ ▄▀▀ ██▀ █▀▄ ▀█▀   █▄ ▄█ ▄▀▄ █▀▄ ██▀
-- █ █ ▀█ ▄██ █▄▄ █▀▄  █    █ ▀ █ ▀▄▀ █▄▀ █▄▄

-- visual mode
-- █ █ █ ▄▀▀ █ █ ▄▀▄ █     █▄ ▄█ ▄▀▄ █▀▄ ██▀
-- ▀▄▀ █ ▄██ ▀▄█ █▀█ █▄▄   █ ▀ █ ▀▄▀ █▄▀ █▄▄

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- clipboard
keymap("v", "<C-y>", '"+y', opts)
keymap("v", "p", '"_dP', opts)

-- replace with register
keymap("v", "gr", '"adp', opts)

-- visual block mode
-- █ █ █ ▄▀▀ █ █ ▄▀▄ █     ██▄ █   ▄▀▄ ▄▀▀ █▄▀   █▄ ▄█ ▄▀▄ █▀▄ ██▀
-- ▀▄▀ █ ▄██ ▀▄█ █▀█ █▄▄   █▄█ █▄▄ ▀▄▀ ▀▄▄ █ █   █ ▀ █ ▀▄▀ █▄▀ █▄▄

-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- command mode
-- ▄▀▀ ▄▀▄ █▄ ▄█ █▄ ▄█ ▄▀▄ █▄ █ █▀▄   █▄ ▄█ ▄▀▄ █▀▄ ██▀
-- ▀▄▄ ▀▄▀ █ ▀ █ █ ▀ █ █▀█ █ ▀█ █▄▀   █ ▀ █ ▀▄▀ █▄▀ █▄▄

keymap("c", "ç", "<CR>", term_opts)
keymap("c", "Ç", "<CR>", term_opts)

keymap("c", "<C-ç>", "ç", term_opts)
keymap("c", "<C-S-ç>", "Ç", term_opts)

-- terminal mode

-- navigation
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", term_opts)

keymap("t", "<ESC>", "<C-\\><C-n>", term_opts)

-- plugins
-- ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
-- ██░▄▄░██░█████░██░██░▄▄░█▄░▄██░▀██░██░▄▄▄░██
-- ██░▀▀░██░█████░██░██░█▀▀██░███░█░█░██▄▄▄▀▀██
-- ██░█████░▀▀░██▄▀▀▄██░▀▀▄█▀░▀██░██▄░██░▀▀▀░██
-- ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀

-- lsp
keymap("n", "<leader>dt", "<CMD>TroubleToggle<CR>", opts)

-- alpha
keymap("n", "<leader>;", ":Alpha<CR>", opts)

-- nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- keymap("n", "<leader>e", ":NERDTreeToggle<CR>", opts)

-- telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fs", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)

keymap("n", "<F2>", "<Cmd>Lspsaga rename<CR>", opts)

-- FTerm
keymap("n", "<A-t>", '<CMD>lua require("FTerm").toggle()<CR>', term_opts)
keymap("t", "<A-t>", '<C-\\><C-n><CMD>lua require("FTerm").close()<CR>', term_opts)

-- DAP
-- keymap("n", "<leader>db", "<CMD> lua require'dap'.toggle_breakpoint()<CR>", term_opts)
-- keymap("n", "<leader>k", "<CMD> lua require'dap'.step_out()<CR>", term_opts)
-- keymap("n", "<leader>j", "<CMD> lua require'dap'.step_over()<CR>", term_opts)
-- keymap("n", "<leader>l", "<CMD> lua require'dap'.step_into()<CR>", term_opts)
-- keymap("n", "<leader>ds", "<CMD> lua require'dap'.close()<CR>", term_opts)
-- keymap("n", "<leader>dn", "<CMD> lua require'dap'.continue()<CR>", term_opts)
-- keymap("n", "<leader>dk", "<CMD> lua require'dap'.up()<CR>", term_opts)
-- keymap("n", "<leader>dj", "<CMD> lua require'dap'.down()<CR>", term_opts)
-- keymap("n", "<leader>d_", "<CMD> lua require'dap'.run_last()<CR>", term_opts)
-- keymap("n", "<leader>dr", "<CMD> lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l", term_opts)
-- keymap("n", "<leader>di", "<CMD> lua require'dap.ui.widgets'.hover()<CR>", term_opts)
-- keymap("n", "<leader>dI", "<CMD> lua require'dap.ui.variables'.visual_hover()<CR>", term_opts)
-- keymap(
-- 	"n",
-- 	"<leader>d?",
-- 	"<CMD> lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
-- 	term_opts
-- )
-- keymap("n", "<leader>de", "<CMD> lua require'dap'.set_exception_breakpoints()<CR>", term_opts)
-- keymap("n", "<leader>da", "<CMD> lua require'debugHelper'.atta()<CR>", term_opts)
-- keymap("n", "<leader>dA", "<CMD> lua require'dap'.run_last()<CR>", term_opts)

-- keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
-- keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
-- keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
-- keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
-- keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
-- keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
-- keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
-- keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opts)

local status, ls = pcall(require, "luasnip")
if not status then
	return
end
vim.keymap.set({ "i", "s" }, "<C-e>", function()
	if ls.expandable() then
		ls.expand()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-p>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<C-k>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)

vim.keymap.set("i", "<C-j>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end, opts)

keymap("n", "<leader><leader>s", "<CMD>source ~/.config/nvim/init.lua<CR>", opts)
