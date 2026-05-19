local constants = {
	port = 4455,
	password_file = "~/.config/hypr/.secrets/obs_ws",
}

---Reads the obs password from the password_file,
---then creates and returns the obs websocket url
---@return string
local function obs_ws_url()
	local file = io.open(constants.password_file, "r")
	if file == nil then
		return ""
	end
	local password = file:read("a")
	file:close()
	return ("obsws://localhost:%d/%s"):format(constants.port, password)
end

---runs obs-cmd using the given `command` as a parameter
---@param command string
local function obs_cmd(command)
	hl.exec_cmd(("obs-cmd -w %s %s"):format(obs_ws_url(), command))
end

local function obs_toggle_rec()
	obs_cmd("recording toggle")
end

local shared = require("config.shared")

---@type table<bind>
return {
	{
		-- mainMod + ^
		keys = { shared.mainMod, "code:49" },
		action = obs_toggle_rec,
	},
	{
		keys = { shared.mainMod, "TAB" },
		action = obs_toggle_rec,
	},
}
