---@type vim.lsp.Config
return {
	cmd = { "lua-language-server" },
	filetypes = {
		"lua",
		"lua.lua",
	},
	root_markers = { ".luarc.json", ".luarc.jsonc" },

	init_options = {
		maxTsServerMemory = 4096, -- Limit memory usage
		disableAutomaticTypingAcquisition = true, -- Don't auto-fetch @types packages
		watchOptions = {
			watchFile = "useFsEvents",
			watchDirectory = "useFsEvents",
			fallbackPolling = "dynamicPriority",
		},
	},

	capabilities = {
		documentFormatting = false, -- Disable formatting if not needed
		documentRangeFormatting = false,
		references = false, -- Disable if you don't use references
	},

	settings = {
		Lua = {
			workspace = {
				cache = {
					-- -- Maximum number of files to cache
					-- maxFiles = 1000,
					-- -- Maximum age of cache entries in milliseconds
					-- maxAge = 3600000, -- 1 hour
				},
				ignoreDir = { ".git" },
				-- Limit workspace scanning
				maxPreload = 2000, -- Adjust based on your project (lower = faster startup)
				preloadFileSize = 150, -- Skip files larger than this (in KB)
				checkThirdParty = false, -- Might help if it's scanning too many external libs
			},

			completion = {
				callSnippet = "Replace",
			},
			-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
}
