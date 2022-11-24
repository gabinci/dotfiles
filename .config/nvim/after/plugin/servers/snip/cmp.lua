#!/usr/bin/env lua
-- Filename: cmp.lua
-- Last Change: Wed, 23 Nov 2022 - 09:06:23
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

local types = require("cmp.types")
local str = require("cmp.utils.str")

---@cast cmp -?

-- load friendly snippets
vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({

	mapping = {
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-x>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
		["<C-SPACE>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- Accept currently selected item. If none selected, `select` first item.
	},

	-- Set `select` to `false` to only confirm explicitly selected items.
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "spell" },
	}),

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	experimental = {
		ghost_text = true,
		native_menu = false,
	},

	formatting = {
		fields = {
			cmp.ItemField.Kind,
			cmp.ItemField.Abbr,
			cmp.ItemField.Menu,
		},

		format = lspkind.cmp_format({
			with_text = false,
			before = function(entry, vim_item)
				local word = entry:get_insert_text()
				if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
					word = vim.lsp.util.parse_snippet(word)
				end
				word = str.oneline(word)
				if
					entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
					and string.sub(vim_item.abbr, -1, -1) == "~"
				then
					word = word .. "~"
				end
				vim_item.abbr = word
				return vim_item
			end,

			menu = {
				luasnip = "[SNIP]",
				nvim_lsp = "[LSP]",
				path = "[PATH]",
				spell = "[SPELL]",
				buffer = "[BUF]",
			},
		}),
	},
})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])

-- enable for filetype
-- vim.cmd([[
-- augroup autogroupName
--   au!
--   autocmd FileType filetypeName lua require ( "cmp" ).setup.buffer { sources = { { name = ''} } }
-- augroup END
-- ]])

-- disable for ft
-- autocmd FileType fyletypeName lua requrie ( 'cmp' ).setup.buffer { enabled = false }
