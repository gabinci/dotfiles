return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			-------------------
			-- TEXT EDITING: --
			-------------------

			local ai = require("mini.ai") -- Better Around/Inside textobjects
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					-- g = LazyVim.mini.ai_buffer, -- buffer
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			})

			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote

			require("mini.surround").setup()
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']

			-- require("mini.comment").setup()
			require("mini.pairs").setup({})({
				"echasnovski/mini.pairs",
				event = "VeryLazy",
				opts = {
					modes = { insert = true, command = true, terminal = false },
					-- skip autopair when next character is one of these
					skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
					-- skip autopair when the cursor is inside these treesitter nodes
					skip_ts = { "string" },
					-- skip autopair when next character is closing pair
					-- and there are more closing pairs than opening pairs
					skip_unbalanced = true,
					-- better deal with markdown code blocks
					markdown = true,
				},
				config = function(_, opts)
					LazyVim.mini.pairs(opts)
				end,
			})

			require("mini.sessions").setup()

			--------------
			-- VISUALS: --
			--------------

			local statusline = require("mini.statusline")
			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin

			statusline.setup({ use_icons = vim.g.have_nerd_font }) -- set use_icons to true if you have a Nerd Font

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			require("mini.tabline").setup()
			-- require("mini.animate").setup()
			-- require("mini.indentscope").setup()

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
