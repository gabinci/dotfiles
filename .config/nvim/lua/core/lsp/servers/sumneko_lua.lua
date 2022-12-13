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
					-- luasnip
					"ls",
					"i",
					"s",
					"d",
					"c",
					"fmta",
					"fmt",
					"rep",
					"f",
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
