-- Filename: lspconfig.lua
-- Last Change: Wed, 16 Nov 2022 13:36:57
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local typescript_status, typescript = pcall(require, "typescript")
if not typescript_status then
	return
end

local protocol = require("vim.lsp.protocol")

local keymap = vim.keymap.set

-- enable keybindings for available lsp servers
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keymaps
	keymap("n", "<leader>gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)
	keymap("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap("n", "]d", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

	if client.name == "tsservfr" then
		keymap("n", "<leader>rf", ":TypescriptRenameFile<CR>")
	end
end

protocol.CompletionItemKind = {
	"", -- Text
	"", -- Method
	"", -- Function
	"", -- Constructor
	"", -- Field
	"", -- Variable
	"", -- Class
	"ﰮ", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"", -- Value
	"", -- Enum
	"", -- Keyword
	"﬌", -- Snippet
	"", -- Color
	"", -- File
	"", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}

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
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})
