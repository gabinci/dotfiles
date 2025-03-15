return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),

				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
							require("luasnip.loaders.from_snipmate").lazy_load()
							require("luasnip.loaders.from_lua").lazy_load({
								paths = { "~/.config/nvim/lua/snippets" },
							})
						end,
					},
				},
			},

			"saadparwaiz1/cmp_luasnip",
			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"f3fora/cmp-spell",
			"dcampos/cmp-emmet-vim",
			"hrsh7th/cmp-buffer",
			"mattn/emmet-vim",

			{
				"onsails/lspkind.nvim",
				config = function()
					require("vim.lsp.protocol").CompletionItemKind = {
						"", -- Text
						"", -- Method
						"󰊕", -- Function
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
				end,
			},
		},

		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			-- local types = require("cmp.types")
			-- local str = require("cmp.utils.str")

			luasnip.config.setup({
				enable_autosnippets = true,
				history = true, -- This tells LuaSnip to remember to keep around the last snippet. You can jump back into it even if you move outside of the selection
				updateevents = "TextChanged,TextChangedI", -- This one is cool cause if you have dynamic snippets, it updates as you type!
				-- ext_opts = {
				-- [types.choiceNode] = {
				-- 	active = {
				-- 		virt_text = { { " « ", "NonTest" } },
				-- 	},
				-- },
				-- },
				region_check_events = "CursorHold,InsertLeave",
				delete_check_events = "TextChanged,InsertEnter",
				store_selection_keys = "<S-q>",
			})

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(), -- Select next item
					["<C-k>"] = cmp.mapping.select_prev_item(), -- Select previous item
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll the documentation window [b]ack
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll the documentation window [f]orward
					["<C-x>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }), -- aborts completion
					["<TAB>"] = cmp.mapping.confirm({ select = true }), -- Accepts selection
					-- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accepts selection
					["<C-Space>"] = cmp.mapping.complete({}), -- Manually trigger a completion from nvim-cmp.
					["<C-l>"] = cmp.mapping(function() -- go foward in variable expanxion
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function() -- go back in variable expanxion
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					},
					{ name = "emmet_vim" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
					{ name = "spell" },
				},

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				completion = { completeopt = "menu,menuone,noinsert" },

				experimental = {
					ghost_text = true,
				},

				formatting = {
					fields = { "kind", "abbr", "menu" },
					expandable_indicator = true,
					max_width = 0,
					source_names = {
						nvim_lsp = "(LSP)",
						emoji = "(Emoji)",
						path = "(Path)",
						calc = "(Calc)",
						cmp_tabnine = "(Tabnine)",
						vsnip = "(Snippet)",
						luasnip = "(Snippet)",
						buffer = "(Buffer)",
						tmux = "(TMUX)",
						copilot = "(Copilot)",
						treesitter = "(TreeSitter)",
					},

					duplicates = {
						buffer = 1,
						path = 1,
						nvim_lsp = 0,
						luasnip = 1,
					},

					duplicates_default = 0,
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = {
							-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
							-- can also be a function to dynamically calculate max width such as
							-- menu = function() return math.floor(0.45 * vim.o.columns) end,
							menu = 50,
							abbr = 50, -- actual suggestion item
						},
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							-- ...
							return vim_item
						end,
						menu = {
							emmet_vim = "  emmet",
							luasnip = "  snip",
							nvim_lsp = "  lsp",
							path = "  path",
							spell = "󰓆 spell",
							buffer = " buff",
						},
					}),
				},
			})

			vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
		end,
	},
}
