--Remap space as leader key

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
	insert_mode = {},

	normal_mode = {
		["ç"] = { ":", { noremap = true } }, -- remap ç
		["Ç"] = { ":", { noremap = true } }, -- remap Ç
		["<leader><leader>s"] = "<CMD>source ~/.config/nvim/init.lua<CR>", -- source init.lua
		["<leader>nh"] = "<CMD>nohl<CR>", -- remove search highlight
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
		["<leader><TAB>"] = [[:<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>]], -- switch buffer
		["<CR>"] = "gf", -- go to file
	},

	term_mode = {},

	visual_mode = {
		["+"] = "<C-a>",
		["_"] = "<C-x>",
	},

	visual_block_mode = {},

	command_mode = {
		["ç"] = { "<CR>", { noremap = true } },
		["Ç"] = { "<CR>", { noremap = true } },
		-- navigate tab completion with <c-j> and <c-k>
		-- runs conditionally
		["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
		["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
	},
}

local function set_keymaps(mode, key, val)
	local opt = generic_opts[mode] or generic_opts_any
	if type(val) == "table" then
		val = val[1]
		opt = val[2]
	end
	if val then
		vim.keymap.set(mode, key, val, opt)
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
local keymap = vim.keymap.set

-- function keymaps
local function file_exp()
	local nt_status, _ = pcall(require, "nvim-tree")
	if not nt_status then
		keymap("n", "<leader>e", "<CMD>Ex<CR>", generic_opts_any)
	else
		keymap("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", generic_opts_any)
	end
end

file_exp()

local function buff_nav()
	local nt_status, _ = pcall(require, "bufferline")
	if not nt_status then
		vim.keymap.set("n", "<S-h>", "<CMD>bprevious<CR>", generic_opts_any)
		vim.keymap.set("n", "<S-l>", "<CMD>bnext<CR>", generic_opts_any)
	else
		vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", generic_opts_any)
		vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNex<CR>", generic_opts_any)
	end
end

buff_nav()

local function sidebar()
	local sb_status, _ = pcall(require, "sidebar-nvim")
	if sb_status then
		keymap("n", "<leader>b", "<CMD>SidebarNvimToggle<CR>", generic_opts_any)
	end
end

sidebar()
