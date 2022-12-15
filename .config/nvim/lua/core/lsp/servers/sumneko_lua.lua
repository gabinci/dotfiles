return {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					--[[ awesome WM ]]
					"client",
					"awesome",
					"screen",
					"root",
				},
			},
			workspace = {
				library = {
					-- Make the server aware of Neovim runtime files
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}
