local shared = require("config.shared")

---@alias Direction "left"|"right"|"up"|"down"
---@alias WorkspaceDirection "left"|"right"|"origin"

--- Returns the dispatcher to switch to another workspace given the direction.
--- If move_window is set to true, the focused window will also be moved.
---@param direction WorkspaceDirection
---@param move_window boolean
local function switch_workspace(direction, move_window)
	return function()
		local current_workspace = hl.get_active_workspace().id
		local active_monitors = #hl.get_monitors()

		local new_workspace
		if direction == "left" then
			new_workspace = current_workspace - active_monitors
		elseif direction == "right" then
			new_workspace = current_workspace + active_monitors
		elseif direction == "origin" then
			-- TODO: implement 'goto origin workspace'
			-- local active_monitor = hl.get_active_monitor().description
			return
		end

		if new_workspace <= 0 then
			return
		end

		if move_window then
			hl.dispatch(hl.dsp.window.move({ workspace = new_workspace }))
		else
			hl.dispatch(hl.dsp.focus({ workspace = new_workspace }))
		end
	end
end

--- Returns the config for a switch-workspace bind
---@param direction WorkspaceDirection
---@param move_window any
---@return bind
local function switch_workspace_bind(direction, move_window)
	---@type string
	local key = direction
	if direction == "origin" then
		key = "o"
	end

	local keys
	if move_window then
		keys = { shared.mainMod, "CTRL", "SHIFT", key }
	else
		keys = { shared.mainMod, "CTRL", key }
	end

	return {
		keys = keys,
		action = switch_workspace(direction, move_window),
	}
end

--- Moves the focus in the given direction
---@param direction Direction
local function move_focus(direction)
	return function()
		hl.dispatch(hl.dsp.focus({ direction = direction }))
		hl.dispatch(hl.dsp.window.bring_to_top())
	end
end

--- Returns the config for a 'move-focus' bind
---@param direction Direction
---@return bind
local function move_focus_bind(direction)
	return {
		keys = { shared.mainMod, direction },
		action = move_focus(direction),
	}
end

local function move_window_bind(direction)
	return {
		keys = { shared.mainMod, "SHIFT", direction },
		action = hl.dsp.window.move({ direction = direction }),
	}
end

local power_script = "~/.config/hypr/scripts/power.sh"

---@type table<bind>
return {
	{
		keys = { shared.mainMod, "C" },
		action = hl.dsp.window.close(),
	},
	{
		keys = { shared.mainMod, "P" },
		action = hl.dsp.window.pseudo(),
	},
	{
		keys = { shared.mainMod, "J" },
		action = hl.dsp.layout("togglesplit"),
	},
	{
		keys = { shared.mainMod, "F" },
		action = hl.dsp.window.float(),
	},

	switch_workspace_bind("left", false),
	switch_workspace_bind("right", false),
	switch_workspace_bind("left", true),
	switch_workspace_bind("right", true),

	switch_workspace_bind("origin", false),
	switch_workspace_bind("origin", true),

	{
		keys = { shared.mainMod, "mouse:272" },
		action = hl.dsp.window.drag(),
	},
	{
		keys = { shared.mainMod, "mouse:273" },
		action = shared.layout.resize,
	},

	{
		-- CTRL + ALT + delete
		keys = { "CTRL", "ALT", "code:119" },
		action = hl.dsp.exec_cmd(power_script),
	},
	{
		-- mainMod + backspace
		keys = { shared.mainMod, "code:22" },
		action = hl.dsp.exec_cmd(power_script),
	},

	move_focus_bind("left"),
	move_focus_bind("right"),
	move_focus_bind("up"),
	move_focus_bind("down"),

	{
		keys = { shared.mainMod, "mouse_down" },
		action = move_focus("right"),
	},
	{
		keys = { shared.mainMod, "mouse_up" },
		action = move_focus("left"),
	},

	move_window_bind("left"),
	move_window_bind("right"),
	move_window_bind("up"),
	move_window_bind("down"),

	{
		keys = { "ALT", "TAB" },
		action = function()
			hl.dispatch(hl.dsp.window.cycle_next())
			hl.dispatch(hl.dsp.window.bring_to_top())
		end,
	},

	{
		keys = { shared.mainMod, "M" },
		action = hl.dsp.workspace.toggle_special("magic"),
	},
	{
		keys = { shared.mainMod, "SHIFT", "M" },
		action = hl.dsp.window.move({ workspace = "special:magic" }),
	},
}
