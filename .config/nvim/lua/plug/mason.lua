return {
	{
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		config = function()
			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`ts_ls`) will work just fine
				-- ts_ls = {},
				--

				lua_ls = {
					-- cmd = { ... },
					filetypes = {
						"lua",
						"lua.lua",
					},

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
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
