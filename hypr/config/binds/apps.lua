local shared = require("config.shared")
local apps = require("config.apps")

---@type table<bind>
local binds = {
	{
		keys = { shared.mainMod, "Q" },
		action = hl.dsp.exec_cmd(apps.terminal),
	},
	{
		keys = { shared.mainMod, "E" },
		action = hl.dsp.exec_cmd(apps.fileManager),
	},
	{
		keys = { shared.mainMod, "space" },
		action = hl.dsp.exec_cmd(apps.menu),
	},
	{
		keys = { shared.mainMod, "SHIFT", "S" },
		action = hl.dsp.exec_cmd(apps.screenshotUtility),
	},
	{
		keys = { shared.mainMod, "V" },
		action = hl.dsp.exec_cmd(apps.clipboardShow),
	},
	{
		keys = { shared.mainMod, "L" },
		action = hl.dsp.exec_cmd(apps.screenlockUtility),
	},
}

-- mainMod + 1-n  (e.g. "mainMod + 1")
local numbered = {
	apps.fileManager,
	apps.browser,
	apps.spotifyClient,
	apps.terminal,
	apps.discordClient,
}

for i, bind in ipairs(numbered) do
	table.insert(binds, {
		keys = { shared.mainMod, tostring(i) },
		action = hl.dsp.exec_cmd(bind),
	})
end

return binds
