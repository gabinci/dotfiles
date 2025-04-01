return {
	"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
	lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
	enabled = false,
	dependencies = {
		-- main one
		{ "ms-jpq/coq_nvim", branch = "coq" },

		-- 9000+ Snippets
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },

		-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
		-- Need to **configure separately**
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
		-- - shell repl
		-- - nvim lua api
		-- - scientific calculator
		-- - comment banner
		-- - etc
	},
	init = function()
		vim.g.coq_settings = {
			auto_start = true, -- if you want to start COQ at startup
			-- Your COQ settings here
		}
	end,
	config = function()
		vim.g.coq_settings = {
			keymap = {
				recommended = true,
			},
		}
	end,
}
