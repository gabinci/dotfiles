local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { noremap = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--   modes                      key
-- ---------                   -----
--  normal                       n
--  insert                       i
--  visual                       v
--  v-block                      x
--  term                         t
--  command                      c

-- █▄ █ ▄▀▄ █▀▄ █▄ ▄█ ▄▀▄ █     █▄ ▄█ ▄▀▄ █▀▄ ██▀
-- █ ▀█ ▀▄▀ █▀▄ █ ▀ █ █▀█ █▄▄   █ ▀ █ ▀▄▀ █▄▀ █▄▄

--  normal mode
keymap("n", "<leader><leader>s", "<CMD>source ~/.config/nvim/init.lua<CR>", opts) -- source init.lua

-- jump to exact mark
keymap("n", "'", "`", opts)
keymap("n", "`", "'", opts)

-- remap ç to :
keymap("n", "ç", ":", term_opts)
keymap("n", "Ç", ":", term_opts)

keymap("n", "<leader>nh", ":nohl<CR>", opts) -- remove highlights

-- paste the last thing that was yanked, not deleted
keymap("n", ",p", '"0p', opts)
keymap("n", ",P", '"0P', opts)

-- increment / decrement
keymap({ "v", "n" }, "+", "<C-a>", opts)
keymap({ "v", "n" }, "_", "<C-x>", opts)

keymap("n", "<C-a>", "gg<S-v>G", opts) -- select all

keymap("n", "<leader>w", ":up<CR>", opts) -- save file only if there are changes
keymap("n", "<leader>q", "ZZ", opts) -- save and quit
keymap("n", "<leader>dq", "ZQ", opts) -- quit without saving

keymap("n", "<leader>sv", "<C-w>v", opts) -- split vertical
keymap("n", "<leader>sh", "<C-w>s", opts) -- split horizontal
keymap("n", "<leader>sx", ":close<CR>", opts) -- close split

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

-- buffer navigation
keymap("n", "<S-l>", "<CMD>BufferLineCycleNex<CR>", opts)
keymap("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>xx", "<CMD>bdelete<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>", opts)

-- copy current line above and bellow
keymap("n", "<A-J>", "mzyyp`zj", opts)
keymap("n", "<A-K>", "mzyyP`zk", opts)

-- alternate file
keymap(
	"n",
	"<leader><TAB>",
	[[:<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>:normal zz<CR>]],
	opts
)
keymap("n", "<CR>", "gf", opts)

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

-- █░█ ▄▄ █▄▄ █░░ █▀█ █▀▀ █▄▀
-- ▀▄▀ ░░ █▄█ █▄▄ █▄█ █▄▄ █░█
-- visual block mode

-- Move text up and down
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- █▀▀ █▀█ █▀▄▀█ █▀▄▀█ ▄▀█ █▄░█ █▀▄
-- █▄▄ █▄█ █░▀░█ █░▀░█ █▀█ █░▀█ █▄▀
-- command mode

keymap("c", "ç", "<CR>", term_opts)
keymap("c", "Ç", "<CR>", term_opts)

keymap("c", "<C-ç>", "ç", term_opts)
keymap("c", "<C-S-ç>", "Ç", term_opts)

-- █▀█ █░░ █░█ █▀▀ █ █▄░█
-- █▀▀ █▄▄ █▄█ █▄█ █ █░▀█
-- plugins

-- lsp
keymap("n", "<leader>gt", "<CMD>TroubleToggle<CR>", opts)

-- alpha
keymap("n", "<leader>;", ":Alpha<CR>", opts)

-- nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fs", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<F2>", "<Cmd>Lspsaga rename<CR>", opts)

local status, ls = pcall(require, "luasnip")
if not status then
	return
end
keymap({ "i", "s" }, "<C-e>", function()
	if ls.expandable() then
		ls.expand()
	end
end, { silent = true })

keymap({ "i", "s" }, "<C-n>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, { silent = true })

keymap({ "i", "s" }, "<C-p>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

keymap("i", "<C-k>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)

keymap("i", "<C-j>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	end
end, opts)
