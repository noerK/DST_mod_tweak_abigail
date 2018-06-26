local multiplier_health = GetModConfigData("tuning:multiplier_health") or 1
local multiplier_damage_per_second = GetModConfigData("tuning:multiplier_damage_per_second") or 1
local multiplier_dmg_period = GetModConfigData("tuning:multiplier_dmg_period") or 1
local dmg_block_rate = GetModConfigData("tuning:dmg_block_rate") or 0
local multiplier_dmg_to_player = GetModConfigData("tuning:multiplier_dmg_to_player") or 1
local multiplier_movement_speed = GetModConfigData("tuning:multiplier_movement_speed") or 1
local multiplier_flower_cooldown = GetModConfigData("tuning:multiplier_flower_cooldown") or 1
local health_regeneration_rate = GetModConfigData("tuning:health_regeneration_rate") or 1

TUNING.ABIGAIL_HEALTH = TUNING.ABIGAIL_HEALTH * multiplier_health
TUNING.ABIGAIL_DAMAGE_PER_SECOND = TUNING.ABIGAIL_DAMAGE_PER_SECOND * multiplier_damage_per_second
TUNING.ABIGAIL_DMG_PERIOD = TUNING.ABIGAIL_DMG_PERIOD / multiplier_dmg_period
TUNING.ABIGAIL_DAMAGE_REDUCTION = dmg_block_rate
TUNING.ABIGAIL_DMG_PLAYER_PERCENT = TUNING.ABIGAIL_DMG_PLAYER_PERCENT * multiplier_dmg_to_player
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

AddPrefabPostInit("abigail_flower", overwriteFlowerCooldown)
AddPrefabPostInit("abigail", overwriteHealthRegeneration)


