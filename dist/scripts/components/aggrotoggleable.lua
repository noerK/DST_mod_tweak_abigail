local AggroToggleable = Class(function(self, inst)
	self.inst = inst
	self.health_regeneration_rate = 0
	self.health_regeneration_rate_aggressive = 0
	self.use_custom_skin = false

	self:SetAggressive()
	--Override these functions to make them check for the tag first
	if not self.inst.components.combat then return end
	local _CanTarget = self.inst.components.combat.CanTarget
	self._CanTarget = _CanTarget
	self.inst.components.combat.CanTarget = function(self, ...)
		if self.inst:HasTag("aggro_active") then
			return _CanTarget(self, ...)
		else
			return false
		end
	end
	local _SetTarget = self.inst.components.combat.SetTarget
	self._SetTarget = _SetTarget
	self.inst.components.combat.SetTarget = function(...)
		if self.inst:HasTag("aggro_active") then
			return _SetTarget(...)
		else
			return false
		end
	end
	if self.inst.components.aura then
		local _auratestfn = self.inst.components.aura.auratestfn
		self._auratestfn = _auratestfn
		self.inst.components.aura.auratestfn = function(inst, ...)
			if self.inst:HasTag("aggro_active") then
				return _auratestfn(inst, ...)
			else
				return false
			end
		end
	end
end,
nil,
{
})

function AggroToggleable:SetAggressive()
	self.inst:AddTag("aggro_active")
	if self.inst._playerlink ~= nil then
		self.inst._playerlink.components.talker:Say("Fight for me")
	end
	self.inst.components.health:StartRegen(self.health_regeneration_rate_aggressive, 1, true)
	if self.use_custom_skin then
		self.inst.AnimState:SetBuild("ghost_abigail_aggro")
	end
end

function AggroToggleable:SetPassive()
	self.inst:RemoveTag("aggro_active")
	if self.inst._playerlink ~= nil then
		self.inst._playerlink.components.talker:Say("Stay calm")
	end
	self.inst.components.health:StartRegen(self.health_regeneration_rate, 1, true)
	if self.use_custom_skin then
		self.inst.AnimState:SetBuild("ghost_abigail_build")
	end
end

function AggroToggleable:Toggle()
	if self.inst:HasTag("aggro_active") then
		self:SetPassive()
	else
		self:SetAggressive()
	end
end

function AggroToggleable:SetUseCustomSkin(value)
	self.use_custom_skin = value
	if self.inst:HasTag("aggro_active") then
		self:SetAggressive()
	else
		self:SetPassive()
	end
end

function AggroToggleable:OnSave()
	return { active = self.inst:HasTag("aggro_active") }
end

function AggroToggleable:OnLoad(data)
	if data.active == false then
		self:SetPassive()
	else
		self:SetAggressive()
	end
end

--Restore the original functions if the component gets removed
function AggroToggleable:OnRemoveFromEntity()
	if self.inst.components.combat then
		if self._CanTarget then
			self.inst.components.combat.CanTarget = self._CanTarget
		end
		if self._SetTarget then
			self.inst.components.combat.SetTarget = self._SetTarget
		end
	end
	if self.inst.components.aura and self._auratestfn then
		self.inst.components.aura.auratestfn = self._auratestfn
	end
end

return AggroToggleable