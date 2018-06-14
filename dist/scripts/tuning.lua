local multiplier_health = GetModConfigData("tuning:multiplier_health")
local multiplier_damage_per_second = GetModConfigData("tuning:multiplier_damage_per_second")
local multiplier_dmg_period = GetModConfigData("tuning:multiplier_dmg_period")
local multiplier_dmg_player_percent = GetModConfigData("tuning:multiplier_dmg_player_percent")
local multiplier_flower_cooldown = GetModConfigData("tuning:multiplier_flower_cooldown")

TUNING.ABIGAIL_HEALTH = TUNING.ABIGAIL_HEALTH * multiplier_health
TUNING.ABIGAIL_DAMAGE_PER_SECOND = TUNING.ABIGAIL_DAMAGE_PER_SECOND * multiplier_damage_per_second
TUNING.ABIGAIL_DMG_PERIOD = TUNING.ABIGAIL_DMG_PERIOD / multiplier_dmg_period
TUNING.ABIGAIL_DMG_PLAYER_PERCENT = TUNING.ABIGAIL_DMG_PLAYER_PERCENT * multiplier_dmg_player_percent

--TUNING.ABIGAIL_SPEED
-- abigail

local function overwriteFlowerCooldown(inst)
    inst.components.cooldown.cooldown_duration = (TUNING.TOTAL_DAY_TIME * (1 + math.random() * 2)) * multiplier_flower_cooldown
    inst.components.cooldown:StartCharging()
end

AddPrefabPostInit("abigail_flower", overwriteFlowerCooldown)

