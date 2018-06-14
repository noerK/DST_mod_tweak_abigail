name = "Tweak Abigail"
description = "Yet another Abigail-tweak mod.\n\n You can rebalance her and she now can be toggled passive/aggressive (Rezecib's Rebalance - https://steamcommunity.com/sharedfiles/filedetails/?id=741879530)"
author = "noerK"
version = "0.0.1"

--[[
This is yet another abigail mod. Most of hem are just pretty small so i tried to combine the best features.
Trigger war the annoying fact that you cannot properly farm beeboxes with her..

I took the logic for her active/passive mode from Rezecib's Rebalance - https://steamcommunity.com/sharedfiles/filedetails/?id=741879530.
It's a huge rebalancing mod of one of the most famous DST-modders. I only took the abigail part of it.

This mod now combines:
 - Abigail can be disengaged/engaged (making her passive) -> (Rezecib's Rebalance)
 - Other Players can not attack her while not in PVP -> (Rezecib's Rebalance)
 - You can rebalance HP, DMG, etc
 - You won't autoattack her
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

addMultiplicatorSetting("tuning:multiplier_health", "Hitpoints")
addMultiplicatorSetting("tuning:multiplier_damage_per_second", "Damage")
addMultiplicatorSetting("tuning:multiplier_dmg_period", "Attack Speed")
addMultiplicatorSetting("tuning:multiplier_dmg_player_percent", "Player Damage")
addMultiplicatorSetting("tuning:multiplier_flower_cooldown", "Flower cooldown")

addStaticSetting("symbiosis:sanity_delta_on_summon", "Sanity loss/gain on summon", 50)
addStaticSetting("symbiosis:health_delta_on_summon", "Health loss/gain on summon", 0)

addStaticSetting("symbiosis:sanity_delta_on_death", "Sanity loss/gain on death", 0)
addStaticSetting("symbiosis:health_delta_on_death", "Health loss/gain on death", 0)
addBooleanSetting("symbiosis:kill_abigail", "Kill Abigail on Wendy's death", false)

addKeyBindingSetting("behaviour:toggle_aggressive_key", "Set the Key to toggle aggressive mode")

addBooleanSetting("mute:howling", "Disable Abigails howling", false)