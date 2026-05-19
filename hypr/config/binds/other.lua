local shared = require("config.shared")

local function toggle_gamemode()
	if hl.get_config("animations.enabled") then
		hl.config({
			animations = {
				enabled = false,
			},
			decoration = {
				drop_shadow = false,
				rounding = 0,
				blur = {
					enabled = false,
				},
			},
			general = {
				gaps_in = 0,
				gaps_out = 0,
				border_size = 1,
			},
		})
	else
		require("config.default")
	end
end

local function scan_qr() end

---@type table<bind>
return {
	{
		keys = { shared.mainMod, "F8" },
		action = toggle_gamemode,
	},
	{
		keys = { shared.mainMod, "CTRL", "S" },
		action = scan_qr,
	},
}
