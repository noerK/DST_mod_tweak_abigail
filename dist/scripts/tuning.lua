local multiplier_health = GetModConfigData("tuning:multiplier_health")
local multiplier_damage_per_second = GetModConfigData("tuning:multiplier_damage_per_second")
local dmg_block_rate = GetModConfigData("tuning:dmg_block_rate")
local dmg_to_player = GetModConfigData("tuning:dmg_to_player")
local multiplier_movement_speed = GetModConfigData("tuning:multiplier_movement_speed")
local multiplier_flower_cooldown = GetModConfigData("tuning:multiplier_flower_cooldown")
local health_regeneration_rate = GetModConfigData("tuning:health_regeneration_rate")
local aggro_health_regeneration_rate = GetModConfigData("tuning:aggro_health_regeneration_rate")

local multiplier_aura_dmg_tick = GetModConfigData("tuning:multiplier_aura_dmg_tick")
local multiplier_aura_dmg_size = GetModConfigData("tuning:multiplier_aura_dmg_size")

TUNING.ABIGAIL_HEALTH = TUNING.ABIGAIL_HEALTH * multiplier_health
TUNING.ABIGAIL_DAMAGE_PER_SECOND = TUNING.ABIGAIL_DAMAGE_PER_SECOND * multiplier_damage_per_second
TUNING.ABIGAIL_DAMAGE_REDUCTION = dmg_block_rate
TUNING.ABIGAIL_DMG_PLAYER_PERCENT = dmg_to_player
TUNING.ABIGAIL_SPEED = TUNING.ABIGAIL_SPEED * multiplier_movement_speed

local function overwriteFlowerCooldown(inst)
    if inst ~= nil then
        if inst.components.cooldown == nil then
            inst:AddComponent("cooldown")
        end
        inst.components.cooldown.cooldown_duration = (TUNING.TOTAL_DAY_TIME * (1 + math.random() * 2)) * multiplier_flower_cooldown
        inst.components.cooldown:StartCharging()
    end
end

local function overwriteAbigailComponents(inst)
    if inst ~= nil then
        if inst.components.health ~= nil then
            inst.components.health:StartRegen(health_regeneration_rate, 1, true)
            inst.components.health:SetAbsorptionAmount(TUNING.ABIGAIL_DAMAGE_REDUCTION)
        end

        if inst.components.aura ~= nil then
            inst.components.aura.radius = 3 * multiplier_aura_dmg_size
            inst.components.aura.tickperiod = 1 / multiplier_aura_dmg_tick
        end
    end
end

AddPrefabPostInit("abigail_flower", overwriteFlowerCooldown)
AddPrefabPostInit("abigail", overwriteAbigailComponents)


