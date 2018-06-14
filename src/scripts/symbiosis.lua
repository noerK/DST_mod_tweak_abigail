local symbiosis_kill_abigail = GetModConfigData("symbiosis:kill_abigail")
local symbiosis_health_delta_on_death = GetModConfigData("symbiosis:health_delta_on_death")
local symbiosis_sanity_delta_on_death = GetModConfigData("symbiosis:sanity_delta_on_death")

local function killAbigail(inst)
	if inst.abigail ~= nil then
		inst.abigail.components.health:Kill()
	end
end

AddPrefabPostInit("wendy", function(inst) inst:ListenForEvent("death", killAbigail) end)

local function influenceWendy(inst)
	-- just because it is possible to spawn abi via console without an wendy assigned to her
	if inst._playerlink ~= nil then 
		inst._playerlink.components.sanity:DoDelta(symbiosis_sanity_delta_on_death)
		inst._playerlink.components.health:DoDelta(symbiosis_health_delta_on_death)
	end

end

AddPrefabPostInit("abigail", function(inst) inst:ListenForEvent("death", influenceWendy) end)


if GetModConfigData("symbiosis:disable_overwriting_code") ~= true then
    modimport("scripts/summonAbigail.lua")
end
