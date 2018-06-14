name = "Tweak Abigail [Alpha]"
description = "Yet another Abigail-tweak mod.\n\n"
.."Abigail now can be toggled passive/aggressive (Rezecib's Rebalance)\n\n"
.."Abigail now can be muted\n\n"
.."You and others won't autoattack her by accident anymore\n\n"
.."You will be able to adjust her stats\n\n"
.."You will be able to adjust her and Wendys symbiosis\n\n"
author = "noerK"
version = "0.0.1"

--[[
[h1][noparse][CAUTION] This is an alpha - so bugs may occur! [CAUTION][/noparse][/h1]

This is yet another abigail mod. Most of hem are just pretty small so i tried to combine the best features.
Trigger war the annoying fact that you cannot properly farm beeboxes with her..

This mod now combines:
	- Abigail can be set aggressive/passive -> (Rezecib's Rebalance)
	- Abigail will have red eyes on aggressive-mode and looks normal on passive mode
	- You can set a key for the aggressive-mode-toggle
	- Other Players can not attack her while not in PVP -> (Rezecib's Rebalance)
	- You won't autoattack her
	- You can disable abigails howling-loop (other sounds will work)
	- You can adjust following stats:
		- Hitpoints
		- Damage
		- Player damage
		- Attackspeed
		- Movementspeed
		- Flower cooldown
	- You can adjust following values regarding wendys and abigails symbiosis:
		- health loss/gain on summon
		- sanity loss/gain on summon
		- health loss/gain on death
		- sanity loss/gain on death
		- kill abigail on wendys death

I took the logic for her active/passive mode from [url=https://steamcommunity.com/sharedfiles/filedetails/?id=741879530]Rezecib's Rebalance[/url]
Idea (not code) for "kill abigail on wendys death" - [url=https://steamcommunity.com/sharedfiles/filedetails/?id=353875384]Abigail's Woe[/url]
Idea (not code) for "You can disable abigails howling-loop (other sounds will work)" - [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1201377696]Shut up, Abigail.[/url]

[b]Feel free to post be ideas, bugs, etc. :)[/b]

[h1][noparse][CAUTION] This is an alpha - so bugs may occur! [CAUTION][/noparse][/h1]

]]

icon_atlas = "preview.xml"
icon = "preview.tex"

forumthread = ""

api_version = 10

priority = 1

server_filter_tags = {"tweak", "wendy", "abigail"}

dst_compatible = true

client_only_mod = false
all_clients_require_mod = true

configuration_options = {}

local multiplicator_options = {}
for i=0,30 do
	multiplicator_options[i+1] = {
		description = "" .. (i*10) .. "%",
		data = ((i*10)/100)
	}
end

local static_options = {}
for i=-40,40 do
	static_options[i+41] = {
		description = "" .. (i*5) .. "",
		data = (i*5)
	}
end

local boolean_options = {
	{
		description = "Yes",
		data = true
	},
	{
		description = "No",
		data = false
	},
}

local alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local key_options = {}
for i=1,#alphabet do
	key_options[i] = {description = alphabet[i], data = 96 + i}
end

local function addMultiplicatorSetting(name, label, default, hover)
	configuration_options[#configuration_options + 1] = {
		name = name,
		label = label,
		options = multiplicator_options,
		default = default or 1,
		hover = hover or nil
	}
end

local function addStaticSetting(name, label, default, hover)
	configuration_options[#configuration_options + 1] = {
		name = name,
		label = label,
		options = static_options,
		default = default or 0,
		hover = hover or nil
	}
end

local function addBooleanSetting(name, label, default, hover)
	configuration_options[#configuration_options + 1] = {
		name = name,
		label = label,
		options = boolean_options,
		default = default or true,
		hover = hover or nil
	}
end

local function addKeyBindingSetting(name, label, default, hover)
	configuration_options[#configuration_options + 1] = {
		name = name,
		label = label,
		options = key_options,
		default = 110,
		hover = hover or nil
	}
end

local function addSettingTitle(title)
	return {
		name = title,
		options = {{description = "", data = 0}},
		default = 0,
	}
end

addSettingTitle("Stats:")
addMultiplicatorSetting("tuning:multiplier_health", "Hitpoints")
addMultiplicatorSetting("tuning:multiplier_damage_per_second", "Damage")
addMultiplicatorSetting("tuning:multiplier_dmg_period", "Attack speed")
addMultiplicatorSetting("tuning:multiplier_dmg_player_percent", "Player damage")
addMultiplicatorSetting("tuning:multiplier_movement_speed", "Movementspeed")
addMultiplicatorSetting("tuning:multiplier_flower_cooldown", "Flower cooldown")

addSettingTitle("Symbiosis:")
addStaticSetting("symbiosis:sanity_delta_on_summon", "Sanity loss/gain on summon", -50)
addStaticSetting("symbiosis:health_delta_on_summon", "Health loss/gain on summon", 0)
addStaticSetting("symbiosis:sanity_delta_on_death", "Sanity loss/gain on death", 0)
addStaticSetting("symbiosis:health_delta_on_death", "Health loss/gain on death", 0)
addBooleanSetting("symbiosis:kill_abigail", "Kill Abigail on Wendy's death", false)

addSettingTitle("Brains:")
addBooleanSetting("mute:howling", "Disable Abigails howling", false)
addKeyBindingSetting("behaviour:toggle_aggressive_key", "Set the Key to toggle aggressive mode")