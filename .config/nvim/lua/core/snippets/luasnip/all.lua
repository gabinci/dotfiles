---@diagnostic disable
-- current file path: /home/gabinci/dotfiles/.config/nvim/snippets/all.lua
-- last change: Wed, 14 Dec 2022 - 12:57:15
-- Author: gabinci

return {
	s(
		{
			trig = "__skel",
			desc = "boil",
		},
		fmta(
			[[
    <>
    <>
    <>
    ]],
			{
				f(function()
					return "-- current file path: " .. vim.fn.expand("%")
				end),
				f(function()
					return "-- last change: " .. os.date("%a, %d %b %Y - %H:%M:%S")
				end),
				f(function()
					return "-- Author: " .. os.getenv("USER")
				end),
			}
		)
	),
}
