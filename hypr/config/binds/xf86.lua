local pactl_defaults = {
	sink = "@DEFAULT_SINK@",
	source = "@DEFAULT_SOURCE@",
}

local function pactl(command, scope, arg)
	return hl.dsp.exec_cmd(("pactl %s %s %s"):format(command, scope, arg))
end

local function change_volume(value)
	return pactl("set-sink-volume", pactl_defaults.sink, value)
end

local function mute()
	return pactl("set-source-mute", pactl_defaults.source, "toggle")
end

local apps = require("config.apps")
local function player(action)
	local scope = apps.spotifyClient .. ",spotify,%any"
	return hl.dsp.exec_cmd(("playerctl -p %s %s"):format(scope, action))
end

local function brightness(value)
	-- TODO: in the previous version, this sent a notification too
	return hl.dsp.exec_cmd(("brightnessctl s %s"):format(value))
end

---@type table<bind>
return {
	{
		keys = { "XF86AudioRaiseVolume" },
		flags = { repeating = true },
		action = change_volume("+5%"),
	},
	{
		keys = { "XF86AudioLowerVolume" },
		flags = { repeating = true },
		action = change_volume("-5%"),
	},
	{
		keys = { "SHIFT", "XF86AudioRaiseVolume" },
		flags = { repeating = true },
		action = change_volume("+1%"),
	},
	{
		keys = { "SHIFT", "XF86AudioLowerVolume" },
		flags = { repeating = true },
		action = change_volume("-1%"),
	},
	{
		keys = { "XF86AudioMute" },
		action = mute(),
	},
	{
		keys = { "CTRL", "ALT", "F" },
		action = mute(),
	},

	{
		keys = { "XF86AudioPlay" },
		flags = { repeating = true },
		action = player("play-pause"),
	},
	{
		keys = { "XF86AudioNext" },
		flags = { repeating = true },
		action = player("next"),
	},
	{
		keys = { "XF86AudioPrev" },
		flags = { repeating = true },
		action = player("previous"),
	},

	{
		keys = { "XF86MonBrightnessUp" },
		flags = { repeating = true },
		action = brightness("+5%"),
	},
	{
		keys = { "XF86MonBrightnessDown" },
		flags = { repeating = true },
		action = brightness("5%-"),
	},
}
