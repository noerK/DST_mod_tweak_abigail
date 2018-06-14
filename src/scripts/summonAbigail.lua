local symbiosis_health_delta_on_summon = GetModConfigData("symbiosis:health_delta_on_summon")
local symbiosis_sanity_delta_on_summon = GetModConfigData("symbiosis:sanity_delta_on_summon")

local function ondeath(inst, deadthing, killer)
    if inst._chargestate == 3 and
        inst._playerlink ~= nil and
        inst._playerlink.abigail == nil and
        inst._playerlink.components.leader ~= nil and
        inst.components.inventoryitem.owner == nil and
        deadthing ~= nil and
        not (deadthing:HasTag("wall") or deadthing:HasTag("smashable")) then

        if deadthing:IsValid() then
            if not inst:IsNear(deadthing, 16) then
                return
            end
        elseif killer == nil or not inst:IsNear(killer, 16) then
            return
        end

        inst._playerlink.components.sanity:DoDelta(TUNING.SANITY_HUGE)

		inst._playerlink.components.sanity:DoDelta(symbiosis_sanity_delta_on_summon)
		inst._playerlink.components.health:DoDelta(symbiosis_health_delta_on_summon)

        if abigail ~= nil then
            if GetModConfigData("mute:howling") ~= true then
                abigail.SoundEmitter:KillSound("howl")
            end
        end

	end
end

AddPrefabPostInit("abigail_flower", function(inst) 
    inst:ListenForEvent("entity_death", function(world, data)
		ondeath(inst, data.inst)
    end, TheWorld)

    inst:ListenForEvent("killed", function(player, data)
		ondeath(inst, data.victim, player)
	end, inst._playerlink)
end)