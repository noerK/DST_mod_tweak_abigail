local symbiosis_kill_abigail = GetModConfigData("symbiosis:kill_abigail")
local symbiosis_health_delta_on_death = GetModConfigData("symbiosis:health_delta_on_death")
local symbiosis_sanity_delta_on_death = GetModConfigData("symbiosis:sanity_delta_on_death")
local symbiosis_health_delta_on_summon = GetModConfigData("symbiosis:health_delta_on_summon")
local symbiosis_sanity_delta_on_summon = GetModConfigData("symbiosis:sanity_delta_on_summon")

TUNING.ORIGINAL_SANITY_HUGE = TUNING.SANITY_HUGE

local function killAbigail(inst)
    if inst.abigail ~= nil then
        inst.abigail.components.health:Kill()
    end
end

local function influenceWendy(inst)
    -- just because it is possible to spawn abi via console without an wendy assigned to her
    if inst._playerlink ~= nil then
        inst._playerlink.components.sanity:DoDelta(symbiosis_sanity_delta_on_death)
        inst._playerlink.components.health:DoDelta(symbiosis_health_delta_on_death)
    end
end

AddPrefabPostInit("wendy", function(inst)
    inst:ListenForEvent("death", killAbigail)

    local old_onDespawn = inst.OnDespawn

    inst.OnDespawn = function(inst)
        if inst.abigail ~= nil then
            inst.abigail:RemoveEventCallback("death", influenceWendy)
        end
        old_onDespawn(inst)
    end
end)

AddPrefabPostInit("abigail", function(inst) inst:ListenForEvent("death", influenceWendy) end)

function pre_ondeath(inst, deadthing, killer)
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

        -- do mod settings delta here
        inst._playerlink.components.sanity:DoDelta(symbiosis_sanity_delta_on_summon)
        inst._playerlink.components.health:DoDelta(symbiosis_health_delta_on_summon)
        -- //

	end
end

local function muteAbigail(player)
    if player ~= nil and player.abigail ~= nil then
        if GetModConfigData("mute:howling") == true then
            player.abigail.SoundEmitter:KillSound("howl")
        end
    end
end

local function sanityDown()
    TUNING.SANITY_HUGE = 0
end

local function sanityUp()
    TUNING.SANITY_HUGE = TUNING.ORIGINAL_SANITY_HUGE
end

AddPrefabPostInit("abigail_flower", function(inst)
    local player = inst._playerlink
    local old_onplayerkillthing = inst._onplayerkillthing
    local old_onentitydeath = inst._onentitydeath

    inst._onplayerkillthing = function(player, data)
        sanityDown()

        pre_ondeath(inst, player, data)
        old_onplayerkillthing(player, data)

        sanityUp()

        muteAbigail(player)
    end

    inst._onentitydeath = function(world, data)
        sanityDown()

        pre_ondeath(inst, world, data)
        old_onentitydeath(world, data)

        sanityUp()

        muteAbigail(player)
    end
end)