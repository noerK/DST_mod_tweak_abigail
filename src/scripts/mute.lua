if GetModConfigData("mute:howling") == true then
    AddPrefabPostInit("abigail", function(inst) inst.SoundEmitter:KillSound("howl") end)
end