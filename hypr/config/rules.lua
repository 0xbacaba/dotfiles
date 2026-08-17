hl.window_rule({
	name = "suppress_maximize",
	maximize = false,
})

hl.window_rule({
	name = "kde_file_picker_float",
	match = {
		class = "^(org\\.freedesktop\\.impl\\.portal\\.desktop\\.kde)$",
	},

	float = true,
	size = { 1000, 580 },
	center = true,
})

local floating = {
	{
		name = "clipse",
		class = "^clipse$",
		size = { 500, 500 },
	},
	{
		name = "pavucontrol",
		class = "^org\\.pulseaudio\\.pavucontrol$",
		size = { 444, 464 },
	},
	{
		name = "homeassistant",
		class = "^Home Assistant Desktop$",
		size = { 331, 300 },
	},
}

for _, app in ipairs(floating) do
	hl.window_rule({
		name = app.name,
		match = {
			class = app.class,
		},

		size = app.size,
		float = true,
		move = { "monitor_w - window_w - 8", "monitor_h - window_h - 46" },
	})
end

hl.window_rule({
	name = "fix_steam_float",
	match = {
		class = "steam",
		initial_title = "Steam",
	},

	float = false,
	maximize = false,
})
hl.window_rule({
	name = "fix_freecad_transparency",
	match = {
		class = "^org\\.freecad\\.FreeCAD$",
	},

	force_rgbx = true,
})
