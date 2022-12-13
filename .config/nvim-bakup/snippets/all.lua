-- current file path: /home/gabinci/dotfiles/.config/nvim/snippets/all.lua
-- last change: Tue, 22 Nov 2022 - 15:23:40
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
