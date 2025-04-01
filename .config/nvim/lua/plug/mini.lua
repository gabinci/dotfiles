return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			require("mini.tabline").setup()
			require("mini.pairs").setup()

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			require("mini.sessions").setup()
			require("mini.icons").setup()
			require("mini.files").setup({

				-- Module mappings created only inside explorer.
				-- Use `''` (empty string) to not create one.
				mappings = {
					synchronize = "`",
				},

				-- Customization of explorer windows
				windows = {
					max_number = math.huge, -- Maximum number of windows to show side by side
					preview = true, -- Whether to show preview of file/directory under cursor
					width_focus = 50, -- Width of focused window
					width_nofocus = 15, -- Width of non-focused window
					width_preview = 40, -- Width of preview window
				},
			})

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim

			-- require("mini.snippets").setup()
			-- require("mini.completion").setup({
			-- 	delay = { completion = 100, info = 100, signature = 50 },
			-- 	window = {
			-- 		info = { height = 25, width = 80, border = "single" },
			-- 		signature = { height = 25, width = 80, border = "single" },
			-- 	},
			-- })
		end,
		keys = {
			{
				"<leader>e",
				function()
					MiniFiles.open()
				end,
				desc = "Open File Explorer",
			},
			{
				"<ESC>",
				function()
					MiniFiles.close()
				end,
				desc = "Close File Explorer",
			},
		},
	},
}
