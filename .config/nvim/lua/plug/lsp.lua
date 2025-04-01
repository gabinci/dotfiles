return {
	-- LSP Plugins
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- "hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("lspconfig").lua_ls.setup({
				root_dir = function(fname)
					local startpath = vim.fn.fnamemodify(fname, ":p:h") -- Get the directory of the current file
					local git_dir = vim.fs.find(".git", { path = startpath, upward = true }) -- Search for the nearest .git directory
					if git_dir[1] then -- If .git is found, return its parent directory as the root
						return vim.fs.dirname(git_dir[1])
					else
						return startpath -- If not found, return the current directory
					end
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local snacks = require("snacks.picker")
					map("gd", snacks.lsp_definitions, "[g]oto [d]efinition")
					map("gr", snacks.lsp_references, "[g]oto [r]eferences")
					map("gi", snacks.lsp_implementations, "[g]oto [i]mplementation")
					map("<leader>D", snacks.lsp_type_definitions, "type [D]efinition")
					map("<leader>ds", snacks.lsp_symbols, "[d]ocument [s]ymbols")
					map("<leader>ws", snacks.lsp_workspace_symbols, "[w]orkspace [s]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
					map("gk", vim.lsp.buf.hover, "hover documentation")

					map("[d", function()
						vim.diagnostic.jump({ count = -1 })
					end, "previous [d]iagnostic")
					map("]d", function()
						vim.diagnostic.jump({ count = 1 })
					end, "next [d]iagnostic")

					map("<leader>d", function()
						vim.diagnostic.open_float({ focus = true })
					end, "show [d]iagnostic")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					-- Assuming 'client' and 'event' are defined in the surrounding scope (e.g., on_attach)
					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({
									group = "kickstart-lsp-highlight",
									buffer = event2.buf,
								})
							end,
						})
					end

					if
						client
						and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		end,
	},
}
