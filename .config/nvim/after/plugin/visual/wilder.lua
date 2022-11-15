-- Filename: wilder.lua
-- Last Change: Wed, 09 Nov 2022 17:08:43
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, wilder = pcall(require, "wilder")
if not status then
	return
end

vim.cmd([[ 
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<C-j>',
      \ 'previous_key': '<C-k>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })
]])

wilder.set_option(
	"renderer",
	wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
		highlights = {
			border = wilder.make_hl("WilderBorder", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#4fA6b1" } }), -- highlight to use for the border
			accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#4fA6b1" } }),
		},

		-- 'single', 'double', 'rounded' or 'solid'
		-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
		border = "rounded",
		pumblend = 20,
		min_width = "100%", -- minimum height of the popupmenu, can also be a number
		max_height = "30%", -- to set a fixed height, set max_height to the same value
		reverse = 0, -- if 1, shows the candidates from bottom to top

		highlighter = wilder.basic_highlighter(),
		left = { " ", wilder.popupmenu_devicons() },
		right = { " ", wilder.popupmenu_scrollbar() },
	}))
)

vim.cmd([[
autocmd CmdlineEnter * ++once call s:wilder_init() | call wilder#main#start()

function! s:wilder_init() abort
  call wilder#setup(...)
  call wilder#set_option(..., ...)

  call wilder#set_option('pipeline', ...)
  call wilder#set_option('renderer', ...)
endfunction
]])

-- wilder.set_option(
-- 	"renderer",
-- 	wilder.renderer_mux({
-- 		[":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
-- 			highlights = {
-- 				border = "Normal", -- highlight to use for the border
-- 			},
-- 			-- 'single', 'double', 'rounded' or 'solid'
-- 			-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
-- 			border = "rounded",
-- 			pumblend = 20,
--			 highlighter = wilder.basic_highlighter(),
-- 			min_width = "100%", -- minimum height of the popupmenu, can also be a number
-- 			max_height = "30%", -- to set a fixed height, set max_height to the same value
-- 			reverse = 0, -- if 1, shows the candidates from bottom to top
-- 			left = { " ", wilder.popupmenu_devicons() },
-- 			right = { " ", wilder.popupmenu_scrollbar() },
-- 		})),
--
-- 		["/"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
-- 			highlights = {
-- 				border = "Normal", -- highlight to use for the border
-- 			},
-- 			-- 'single', 'double', 'rounded' or 'solid'
-- 			-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
-- 			border = "rounded",
-- 			pumblend = 20,
-- 			highlighter = wilder.basic_highlighter(),
-- 			min_width = "100%", -- minimum height of the popupmenu, can also be a number
-- 			max_height = "30%", -- to set a fixed height, set max_height to the same value
-- 			reverse = 0, -- if 1, shows the candidates from bottom to top
-- 			left = { " ", wilder.popupmenu_devicons() },
-- 			right = { " ", wilder.popupmenu_scrollbar() },
-- 		})),
-- 	})
-- )
