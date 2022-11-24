-- Filename: lspconfig.lua
-- Last Change: Wed, 23 Nov 2022 - 14:08:35
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local typescript_status, typescript = pcall(require, "typescript")
if not typescript_status then
	return
end

local keymap = vim.keymap.set

-- enable keybindings for available lsp servers
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

typescript.setup({ server = {
	capabilities = capabilities,
	on_attach = on_attach,
} })

lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					--[[ awesome WM ]]
					"awful",
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
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

lspconfig.emmet_ls.setup({
	-- on_attach = on_attach,
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "markdown" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
