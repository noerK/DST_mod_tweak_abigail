name = "!dev-Tweak Abigail"
description = "Yet another Abigail-tweak mod.\n\n"
.."Abigail now can be toggled passive/aggressive (Rezecib's Rebalance)\n\n"
.."Abigail now can be muted\n\n"
.."You and others won't autoattack her by accident anymore\n\n"
.."You will be able to adjust her stats\n\n"
.."You will be able to adjust her and Wendys symbiosis\n\n"
author = "noerK"
version = "1.2.0"

--[[
[h1]Yet another abigail mod.[/h1]

Most of the available abigail mods are just pretty small so i tried to combine the best features and add some unique ones.
Trigger was the annoying fact that you cannot properly farm beeboxes with her..

[b]Features:[/b]
[list]
	[*] Abigail can be set aggressive/passive -> (Rezecib's Rebalance)
	[*] Abigail will have red eyes on aggressive-mode and looks normal on passive mode
	[*] You can set a key for the aggressive-mode-toggle
	[*] Other Players can not attack her while not in PVP -> (Rezecib's Rebalance)
	[*] You won't autoattack her
	[*] You can disable abigails howling-loop (other sounds will work)
[/list]

[b]Adjust stats:[/b]
[list]
	[*] Hitpoints
	[*] Damage
	[*]	Player damage
	[*] Attackspeed
	[*] Attackrange/Area of effect
	[*] Movementspeed
	[*] Flower cooldown
	[*] Health regeneration -> (kishkuma)
	[*] Health regeneration on aggressive-mode
	[*] Damage reduction/blockrate -> (kishkuma)
[/list]

[b]Change values regarding wendys and abigails symbiosis:[/b]
[list]
	[*] health loss/gain on summon
	[*] sanity loss/gain on summon
	[*] health loss/gain on death
	[*] sanity loss/gain on death
	[*] kill abigail on wendys death
[/list]

I took the logic for her aggressive/passive mode from [url=https://steamcommunity.com/sharedfiles/filedetails/?id=741879530]Rezecib's Rebalance[/url]
Idea for "kill abigail on wendys death" - [url=https://steamcommunity.com/sharedfiles/filedetails/?id=353875384]Abigail's Woe[/url]
Idea for "You can disable abigails howling-loop (other sounds will work)" - [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1201377696]Shut up, Abigail.[/url]
Idea for aggressive-mode reg difference by [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1411742977]TafuSeler[/url]

[b]Feel free to post be ideas, bugs, etc. :)[/b]

Thanks to [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1411742977]kishkuma[/url] for contributing!

My other mods:
[table][tr]
[td][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1417486338][img]https://imgur.com/mL0XSlI.jpg[/img][/url][/td]
[td][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1153998909][img]https://imgur.com/ZHWA3S3.jpg[/img][/url][/td]
[/tr][/table]

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

local function applySettings()
	addSettingTitle("Stats:")
	addSetting("tuning:multiplier_health", "Hitpoints", "%", "The base health is 600HP", 100, 10, 0, 300, true)
	addSetting("tuning:multiplier_damage_per_second", "Damage", "%", "The base damage is 10(day), 20(dusk), 40(night)", 100, 10, 0, 300, true)
	addSetting("tuning:multiplier_aura_dmg_tick", "Attack speed", "%", "The time between attacks is 1 second. On 200% it will be 0.5", 100, 10, 0, 300, true)
	addSetting("tuning:multiplier_aura_dmg_size", "Attack area of effect/range", "%", "Abigail has an aura attack", 100, 5, 0, 200, true)
	addSetting("tuning:dmg_to_player", "Player damage", "%", "Damage when attacking a player.", 25, 5, 0, 200, true)
	addSetting("tuning:multiplier_movement_speed", "Movementspeed", "%", "The base movementspeed is 5", 100, 10, 0, 300, true)
	addSetting("tuning:health_regeneration_rate", "HP gained per second (passive)", " HP/s", "", 1, 1, -50, 50)
	addSetting("tuning:aggro_health_regeneration_rate", "HP gained per second (aggressive)", " HP/s", "", 1, 1, -50, 50)
	addSetting("tuning:dmg_block_rate", "Damage block rate", "%", "Abigail has no armor by default. Now you can give her some.", 0, 5, 0, 100, true)

	addSetting("tuning:multiplier_flower_cooldown", "Flower cooldown", "%", "Original cooldown is 3-4 days. 0% is no cooldown at all", 100, 10, 0, 300, true)

	addSettingTitle("Symbiosis:")
	addSetting("symbiosis:sanity_delta_on_summon", "Sanity loss/gain on summon", "", "", -50, 5, -200, 200)
	addSetting("symbiosis:health_delta_on_summon", "Health loss/gain on summon", "", "", 0, 5)
	addSetting("symbiosis:sanity_delta_on_death", "Sanity loss/gain on death", "", "", 0, 5)
	addSetting("symbiosis:health_delta_on_death", "Health loss/gain on death", "", "", 0, 5)
	addBooleanSetting("symbiosis:kill_abigail", "Kill Abigail on Wendy's death", false)

	addSettingTitle("Brains:")
	addBooleanSetting("mute:howling", "Disable Abigails howling", false)
	addKeyBindingSetting("behaviour:toggle_aggressive_key", "Set the Key to toggle aggressive mode")
	addBooleanSetting("visual:custom_aggressive_skin", "Enable red eyes (custom skin)", true, "Enables the custom skin with red eyes for her aggressive mode.")
end


-- ###################
-- Settings Functions
-- ###################

local function addSetting(name, label, valueType, hover, default, stepParam, minValue, maxValue, m)
	local new_options = {}
	local min = minValue or -200
	local max = maxValue or 200
	local type = valueType or ""
	local step = stepParam or 10


	local minInt = 0
	if min < 0 then
		minInt = -1 * (min / step)
	end

	local maxInt = max / step

	local percentualize = 1

	if m then
		percentualize = 100
	end

	local calculatedDefault = (default or 0) / percentualize

	for i = -1 * minInt, maxInt do
		new_options[i + minInt + 1] = {
			description = "" .. (i * step) .. type .. "",
			data = (i * step) / percentualize
		}
	end

	configuration_options[#configuration_options + 1] = {
		name = name,
		label = label,
		options = new_options,
		default = calculatedDefault,
		hover = hover or nil
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

local function addBooleanSetting(name, label, default, hover)
	configuration_options[#configuration_options + 1] = {
		name = name,
		label = label,
		options = boolean_options,
		default = default or true,
		hover = hover or nil
	}
end

local alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
local key_options = {}
for i=1,#alphabet do
	key_options[i] = {description = alphabet[i], data = 96 + i}
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

appySettings()