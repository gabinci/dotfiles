-- Keymap helper
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Regular mappings per mode (using single-letter mode keys)
local mode_maps = {
	n = {
		-- Buffer management
		["<leader>w"] = { "<CMD>up<CR>", { desc = "Quick save" } },
		["<leader>q"] = { "ZZ", { desc = "Save & quit" } },
		["<leader>dq"] = { "ZQ", { desc = "Quit without saving" } },

		-- Code execution
		["<leader>x"] = { "<cmd>.lua<cr>", { desc = "Execute current line as Lua" } },
		["<leader><leader>x"] = {
			"<cmd>source %<cr><cmd>lua vim.notify('File sourced')<cr>",
			{ desc = "Source current file" },
		},

		-- Window management
		["<leader>sv"] = { "<C-w>v", { desc = "Split vertical" } },
		["<leader>sh"] = { "<C-w>s", { desc = "Split horizontal" } },
		["<leader>sx"] = { ":close<CR>", { desc = "Close split" } },
		["<C-DOWN>"] = { "<CMD>resize -2<CR>", { desc = "Resize window down" } },
		["<C-UP>"] = { "<CMD>resize +2<CR>", { desc = "Resize window up" } },
		["<C-Left>"] = { "<CMD>vertical resize -2<CR>", { desc = "Resize window left" } },
		["<C-Right>"] = { "<CMD>vertical resize +2<CR>", { desc = "Resize window right" } },

		-- Navigation
		["H"] = { "<cmd>bprev<cr>", { desc = "Previous buffer" } },
		["L"] = { "<cmd>bnext<cr>", { desc = "Next buffer" } },
		["n"] = { "nzzzv", { desc = "Next search result (center)" } },
		["N"] = { "Nzzzv", { desc = "Previous search result (center)" } },
		["<C-d>"] = { "<C-d>zz", { desc = "Scroll down (center)" } },
		["<C-u>"] = { "<C-u>zz", { desc = "Scroll up (center)" } },
		["<CR>"] = { "gf", { desc = "Goto file under cursor" } },

		-- Line movement
		["<A-k>"] = { "<Esc>:m .-2<CR>", { desc = "Move line up" } },
		["<A-j>"] = { "<Esc>:m .+1<CR>", { desc = "Move line down" } },
		["<A-K>"] = { "mzyyP`zk", { desc = "Copy line up" } },
		["<A-J>"] = { "mzyyp`zj", { desc = "Copy line down" } },
		["dJ"] = { "ddpkJ", { desc = "Join with line below" } },

		-- Miscellaneous
		["<C-a>"] = { "ggVG", { desc = "Select all" } },
	},
	i = {}, -- Insert mode (if needed)
	v = {
		["+"] = { "<C-a>", { desc = "Increment" } },
		["-"] = { "<C-x>", { desc = "Decrement" } },
	},
	x = {},
	c = {},
	t = {}, -- Terminal mode (if needed)
}

local multi_mode_maps = {
	{
		modes = { "n", "v" },
		maps = {
			["<leader>h"] = {
				function()
					vim.o.hlsearch = not vim.o.hlsearch
					print("hlsearch: " .. tostring(vim.o.hlsearch))
				end,
				{ desc = "Toggle search highlighting" },
			},
		},
	},
	{
		modes = { "n", "v", "x" },
		maps = {
			["ç"] = { ":", { desc = "Enter command mode" } },

			-- Copy and pasting
			[",p"] = { '"+p', { desc = "Paste sytem clipboard" } },
			[",P"] = { '"+P', { desc = "PASTE sytem clipboard" } },
			[",y"] = { '"+y', { desc = "yank to system clipboard" } },
			[",Y"] = { '"+Y', { desc = "YANK to system clipboard" } },
		},
	},
	{
		modes = { "n", "t" },
		maps = {
			["<C-h>"] = { "<C-w>h", { desc = "Move to left window" } },
			["<C-l>"] = { "<C-w>l", { desc = "Move to right window" } },
			["<C-k>"] = { "<C-w>k", { desc = "Move to top window" } },
			["<C-j>"] = { "<C-w>j", { desc = "Move to bottom window" } },
		},
	},
}

-- Register multi-mode mappings
for _, group in ipairs(multi_mode_maps) do
	for lhs, mapping in pairs(group.maps) do
		local rhs = mapping[1]
		local opts = vim.tbl_extend("force", default_opts, mapping[2] or {})
		for _, mode in ipairs(group.modes) do
			keymap(mode, lhs, rhs, opts)
		end
	end
end

-- Register per-mode mappings
for mode, mode_table in pairs(mode_maps) do
	for lhs, mapping in pairs(mode_table) do
		local rhs = mapping[1]
		local opts = mapping[2] or default_opts
		if type(rhs) == "table" then
			rhs, opts = rhs[1], vim.tbl_extend("force", opts, rhs[2] or {})
		end
		keymap(mode, lhs, rhs, vim.tbl_extend("force", default_opts, opts))
	end
end
