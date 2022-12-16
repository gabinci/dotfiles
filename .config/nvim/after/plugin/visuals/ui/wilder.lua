local _, wilder = pcall(require, "wilder")
if not _ then
	require("core.log").log_error("wilder")
	return
end

wilder.setup({
	modes = {
		":",
		"/",
		"?",
	},
	next_key = "<C-k>",
	previous_key = "<C-j>",
	accept_key = "<Down>",
	reject_key = "<Up>",
})

wilder.set_option("pipeline", {
	wilder.branch(
		wilder.python_file_finder_pipeline({
			file_command = function(ctx, arg)
				if string.find(arg, ".") ~= nil then
					return { "fdfind", "-tf", "-H" }
				else
					return { "fdfind", "-tf" }
				end
			end,
			dir_command = { "fd", "-td" },
			filters = { "cpsm_filter" },
		}),
		wilder.substitute_pipeline({
			pipeline = wilder.python_search_pipeline({
				skip_cmdtype_check = 1,
				pattern = wilder.python_fuzzy_pattern({
					start_at_boundary = 0,
				}),
			}),
		}),
		wilder.cmdline_pipeline({
			fuzzy = 2,
			fuzzy_filter = wilder.lua_fzy_filter(),
		}),
		{
			wilder.check(function(ctx, x)
				return x == ""
			end),
			wilder.history(),
		},
		wilder.python_search_pipeline({
			pattern = wilder.python_fuzzy_pattern({
				start_at_boundary = 0,
			}),
		})
	),
})

local highlighters = {
	wilder.pcre2_highlighter(),
	wilder.lua_fzy_highlighter(),
}

local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
	pumblend = 20,
	min_width = "100%", -- minimum height of the popupmenu, can also be a number
	max_height = "25%", -- to set a fixed height, set max_height to the same value
	reverse = 1, -- if 1, shows the candidates from bottom to top	border = "rounded",
	empty_message = wilder.popupmenu_empty_message_with_spinner(),
	highlighter = highlighters,
	left = {
		" ",
		wilder.popupmenu_devicons(),
		wilder.popupmenu_buffer_flags({
			flags = " a + ",
			icons = { ["+"] = "", a = "", h = "" },
		}),
	},
	right = {
		" ",
		wilder.popupmenu_scrollbar(),
	},

	highlights = {
		accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
	},
	border = "rounded",
}))

local wildmenu_renderer = wilder.wildmenu_renderer(wilder.wildmenu_airline_theme({
	highlighter = highlighters,
	pumblend = 20,
	separator = "   ",
	left = { " ", wilder.wildmenu_spinner(), " " },
	right = { " ", wilder.wildmenu_index() },
	highlights = {
		default = "StatusLine",
		accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
	},
}))

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = popupmenu_renderer,
		["/"] = wildmenu_renderer,
		substitute = wildmenu_renderer,
	})
)
