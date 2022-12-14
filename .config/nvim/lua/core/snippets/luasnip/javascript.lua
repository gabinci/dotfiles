---@diagnostic disable
local get_visual = function(args, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else
		return sn(nil, i(1))
	end
end
------------------------------------------------------------------------------
return {
	s(
		{ trig = "clg", dscr = "console.log()" },
		fmta("console.log(<>)", {
			d(1, get_visual),
		})
	),
	s(
		{
			trig = "tag",
			desc = "HTML tags",
		},
		fmt("<{}>{}</{}>", {
			i(1),
			i(2),
			rep(1),
		})
	),
}
