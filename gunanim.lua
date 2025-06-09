local keyPressed, weaponAdded = false, false

local function notify(text, notifType)
    lib.notify({
        description = text,
        type = notifType or 'inform'
    })
end

local function toggleWeaponAnimation()
    if Config.WeaponAnimation == "always" then
        return
    end

    keyPressed = not keyPressed
    notify(keyPressed and "Weapon animation enabled." or "Weapon animation disabled.", keyPressed and "success" or "error")
end

RegisterCommand("ChangeWeaponRunningAnimation", toggleWeaponAnimation)
RegisterKeyMapping("ChangeWeaponRunningAnimation", "Change Weapon Running Animation", "keyboard", Config.ChangeWeaponRunningAnimationKey)

CreateThread(function()
    local sleep = 100
    while true do
        Wait(sleep)
        local ped = PlayerPedId()
        local isArmed = IsPedArmed(ped, 4)

        if Config.WeaponAnimation == "always" or (Config.WeaponAnimation == "key" and keyPressed) then
            if not weaponAdded then
                local hash = GetHashKey("weapon_petrolcan")
                GiveWeaponToPed(ped, hash, 0, false, true)
                RemoveWeaponFromPed(ped, hash)
                weaponAdded = true
            end

            if isArmed then
                SetPedWeaponMovementClipset(ped, "move_ped_wpn_jerrycan_generic", 0.5)
            else
                ResetPedWeaponMovementClipset(ped, 0.0)
            end
        else
            ResetPedWeaponMovementClipset(ped, 0.0)
        end
    end
end)
