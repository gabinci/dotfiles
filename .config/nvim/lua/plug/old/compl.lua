return {
	{
		"brianaung/compl.nvim",
		enabled = false,
		opts = {
			-- Default options (no need to set them again)
			completion = {
				fuzzy = false,
				timeout = 100,
			},
			info = {
				enable = true,
				timeout = 100,
			},
			snippet = {
				enable = false,
				paths = {},
			},
		},
		callback = function()
			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if vim.snippet.active({ direction = 1 }) then
					return "<cmd>lua vim.snippet.jump(1)<cr>"
				end
			end, { expr = true })

			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if vim.snippet.active({ direction = -1 }) then
					return "<cmd>lua vim.snippet.jump(-1)<cr>"
				end
			end, { expr = true })
		end,
	},
}
