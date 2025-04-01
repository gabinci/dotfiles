---@diagnostic disable: undefined-global

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = false, replace_netrw = true },
			lazygit = { enabled = true },

			indent = {
				enabled = true, -- enable indent guides
				priority = 1,
				animate = { enabled = false },
				chunk = { enabled = true },
			},

			input = { enabled = true },
			picker = {
				enabled = true,
				matcher = {
					frecency = true,
					cwd_bonus = true,
				},
				layout = {
					preset = "ivy",
					layout = { position = "bottom" },
				},
			},
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			-- scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = {

			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "[L]azy [G]it",
			},

			-- FIND
			{
				"<leader>ff",
				function()
					Snacks.picker.smart()
				end,
				desc = "[F]ind [F]iles",
			},
			{
				"<leader>fC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "[F]ind [C]olorschemes",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "[F]ind [B]uffers",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "[F]ind [G]rep",
			},
			{
				"<leader>f:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "[F]ind [:]Command History",
			},
			{
				"<leader>fn",
				function()
					Snacks.picker.notifications()
				end,
				desc = "[F]ind [N]otification",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "[F]ind [C]onfigs",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "[F]ind [P]rojects",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "[F]ind [R]ecent",
			},
		},
	},
}
