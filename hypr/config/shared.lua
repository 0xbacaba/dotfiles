local logfile = io.open("/tmp/hyprlua.log", "a+")
if logfile == nil then
	hl.notification.create({
		text = "failed to open logfile",
		timeout = 15,
		color = "red",
	})
end

---@enum Layout
local Layout = {
	dwindle = {
		name = "dwindle",
		resize = hl.dsp.window.resize(),
		custom_action = hl.dsp.layout("togglesplit"),
	},
	scrolling = {
		name = "scrolling",
		resize = hl.dsp.no_op(),
		custom_action = hl.dsp.layout("colresize +conf"),
	},
}

local function trim_left(str)
	return str:gsub("^%s*(.-)", "%1")
end
local function trim_right(str)
	return str:gsub("(.-)%s*$", "%1")
end
local function trim(str)
	return trim_left(trim_right(str))
end

local function notify_err(text)
	hl.notification.create({
		text = text,
		timeout = 5000,
		color = "#f00",
	})
end

local function shell_exec(cmd)
	local handle = io.popen(cmd)
	if not handle then
		return nil
	end
	local result = handle:read("*a")
	handle:close()

	if not result then
		return nil
	end

	return trim(result)
end

local home = os.getenv("HOME")
local uid = shell_exec("id -u")
if not home then
	notify_err("$HOME is unset")
end
if not uid then
	notify_err("Failed to read UID")
end

return {
	mainMod = "SUPER",

	log = function(text)
		if logfile == nil then
			return
		end
		logfile:write(text)
		logfile:write("\n")
	end,

	layout = Layout.dwindle,

	xdg = {
		data = os.getenv("XDG_DATA_HOME") or (home .. "/.local/share"),
		bin = os.getenv("XDG_BIN_HOME") or (home .. "/.local/bin"),
		runtime = os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. uid),
	},
}
