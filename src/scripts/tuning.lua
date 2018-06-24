local multiplier_health = GetModConfigData("tuning:multiplier_health")
local multiplier_damage_per_second = GetModConfigData("tuning:multiplier_damage_per_second")
local multiplier_dmg_period = GetModConfigData("tuning:multiplier_dmg_period")
local multiplier_dmg_block = GetModConfigData("tuning:multiplier_dmg_block")
local multiplier_dmg_player_block = GetModConfigData("tuning:multiplier_dmg_player_block")
local multiplier_movement_speed = GetModConfigData("tuning:multiplier_movement_speed")
local multiplier_flower_cooldown = GetModConfigData("tuning:multiplier_flower_cooldown")
local health_regeneration_rate = GetModConfigData("tuning:health_regeneration_rate")

TUNING.ABIGAIL_HEALTH = TUNING.ABIGAIL_HEALTH * multiplier_health
TUNING.ABIGAIL_DAMAGE_PER_SECOND = TUNING.ABIGAIL_DAMAGE_PER_SECOND * multiplier_damage_per_second
TUNING.ABIGAIL_DMG_PERIOD = TUNING.ABIGAIL_DMG_PERIOD / multiplier_dmg_period
TUNING.ABIGAIL_DAMAGE_REDUCTION = TUNING.ABIGAIL_DAMAGE_REDUCTION * multiplier_dmg_block
TUNING.ABIGAIL_DMG_PLAYER_PERCENT = TUNING.ABIGAIL_DMG_PLAYER_PERCENT * multiplier_dmg_player_block
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

local function overwriteHealthRegeneration(inst)
    if inst ~= nil then
        if inst.components.health ~= nil then
            inst.components.health:StartRegen(health_regeneration_rate, 1, true)
        end
    end
end

local function doOverwrites(inst)
    overwriteFlowerCooldown(inst)
    overwriteHealthRegeneration(inst)
end

AddPrefabPostInit("abigail_flower", doOverwrites)



