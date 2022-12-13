local handlers = require("core.lsp.handlers")
local status, mason = pcall(require, "mason")
if not status then
	return
end

mason.setup({
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,

	ensure_installed = handlers.lsp_servers,
	automatic_installation = true,
})

local m_lspc_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not m_lspc_status then
	return
end

local m_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not m_null_ls_status then
	return
end
mason_lspconfig.setup({
	ensure_installed = handlers.lsp_servers,
})

mason_null_ls.setup({
	ensure_installed = handlers.formaters,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(handlers.lsp_servers) do
	opts = {
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "core.lsp.servers." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end

handlers.setup()
