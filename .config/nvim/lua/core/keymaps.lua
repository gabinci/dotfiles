--Remap space as leader key

local keymap = vim.keymap.set
local generic_opts_any = { noremap = true, silent = true }
local generic_opts = {
	insert_mode = generic_opts_any,
	normal_mode = generic_opts_any,
	visual_mode = generic_opts_any,
	visual_block_mode = generic_opts_any,
	command_mode = generic_opts_any,
	term_mode = { silent = true },
}

local mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	visual_block_mode = "x",
	command_mode = "c",
}

local maps = {

	normal_mode = {
		["ç"] = { ":", { noremap = true } }, -- remap ç
		["Ç"] = { ":", { noremap = true } }, -- remap Ç
		["<leader><leader>s"] = "<CMD>source ~/.config/nvim/init.lua<CR>", -- source init.lua
		[",p"] = '"0p', -- paste last yanked
		[",P"] = '"0P', -- paste last YANKED
		["+"] = "<C-a>", -- increment
		["_"] = "<C-x>", -- decrement
		["<C-a>"] = "gg<S-v>G", -- select all
		["db"] = "vb_d", -- delete backwards
		["<leader>w"] = "<CMD>up<CR>", -- quick save
		["<leader>q"] = "ZZ", -- save & quit
		["<leader>dq"] = "ZQ", -- quit without saving
		["<leader>sv"] = "<C-w>v", -- split vertical
		["<leader>sh"] = "<C-w>s", -- split horizontal
		["<leader>sx"] = ":close<CR>", -- close split
		["<C-h>"] = "<C-w>h", --move to left buffer
		["<C-l>"] = "<C-w>l", -- move to right buffer
		["<C-k>"] = "<C-w>k", -- move to top buffer
		["<C-j>"] = "<C-w>j", --move to bottom buffer
		["<C-DOWN>"] = "<CMD>resize -2<CR>", -- resize buffer
		["<C-UP>"] = "<CMD>resize +2<CR>",
		["<C-Left>"] = "<CMD>vertical resize -2<CR>",
		["<C-Right>"] = "<CMD>vertical resize +2<CR>",
		["<leader>xx"] = "<CMD>bdelete<CR>", -- delete buffer
		["<A-k>"] = "<Esc>:m .-2<CR>", -- move line up
		["<A-j>"] = "<Esc>:m .+1<CR>", -- move line down
		["<A-K>"] = "mzyyP`zk", -- copy line up
		["<A-J>"] = "mzyyp`zj", -- copy line down
		["<CR>"] = "gf", -- goto file
		["<leader><TAB>"] = [[:<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>]], -- switch buffer
		["<ESC>"] = "<cmd>nohlsearch<CR>",
		["<leader>d"] = vim.diagnostic.setloclist,
		["<leader>h"] = {
			[[:exe &hls && v:hlsearch ? ':nohls' : ':set hls'<CR>]],
			{ silent = true, noremap = true, expr = true },
		}, -- toggles highlights
	},

	insert_mode = {
		["jj"] = "<ESC>",
},
	term_mode = {},
	visual_mode = {
		["ç"] = { ":", { noremap = true } }, -- remap ç
		["Ç"] = { ":", { noremap = true } }, -- remap Ç
		["+"] = "<C-a>", -- increment
		["_"] = "<C-x>", -- decrement
	},

	visual_block_mode = {
		["ç"] = { ":", { noremap = true } }, -- remap ç
		["Ç"] = { ":", { noremap = true } }, -- remap Ç
		["<A-k>"] = "<CMD>move '>+1<CR>gv-gv", -- copy line up
		["<A-j>"] = "<CMD>move '<-2<CR>gv-gv", -- copy line down
	},
	-- Move text up and down

	command_mode = {
		["ç"] = { "<CR>", noremap = true },
		["Ç"] = { "<CR>", noremap = true },
		["jj"] = "<ESC>",
	},
}

local function set_keymaps(mode, key, val)
	local opt = generic_opts[mode] or generic_opts_any
	if type(val) == "table" then
		val = val[1]
		opt = val[2]
	end
	if val then
		keymap(mode, key, val, opt)
	else
		pcall(vim.api.nvim_del_keymap, mode, key)
	end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
local function load_mode(mode, keymaps)
	mode = mode_adapters[mode] or mode
	for k, v in pairs(keymaps) do
		set_keymaps(mode, k, v)
	end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
local function load(keymaps)
	keymaps = keymaps or {}
	for mode, mapping in pairs(keymaps) do
		load_mode(mode, mapping)
	end
end

-- Load the default keymappings
local function load_keymaps()
	load(maps)
end

load_keymaps()

-- function keymaps
local function file_exp()
	local nt_status, _ = pcall(require, "nvim-tree")
	if not nt_status then
		keymap("n", "<leader>e", "<CMD>Ex<CR>", generic_opts_any)
		return
	end
	keymap("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", generic_opts_any)
end

file_exp()

local function buff_nav()
	local nt_status, _ = pcall(require, "bufferline")
	if not nt_status then
		keymap("n", "<S-h>", "<CMD>bprevious<CR>", generic_opts_any)
		keymap("n", "<S-l>", "<CMD>bnext<CR>", generic_opts_any)
		return
	end
	keymap("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", generic_opts_any)
	keymap("n", "<S-l>", "<CMD>BufferLineCycleNex<CR>", generic_opts_any)
end

buff_nav()

local function luasnip()
	local status, ls = pcall(require, "luasnip")
	if status then
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
		end, generic_opts_any)

		keymap("i", "<C-j>", function()
			if ls.choice_active() then
				ls.change_choice(-1)
			end
		end, generic_opts_any)
	end
end

luasnip()

local fterm = function()
	local status, _ = pcall(require, "FTerm")
	if status then
		keymap("n", "<A-t>", '<CMD>lua require("FTerm").toggle()<CR>')
		keymap("t", "<A-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
		keymap("t", "<ESC>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
	end
end

fterm()

-- src: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end
keymap("n", "dd", smart_dd, { noremap = true, expr = true })
