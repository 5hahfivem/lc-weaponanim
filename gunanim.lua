local weaponAdded = false
local keyPressed = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = PlayerPedId()

        if Config.WeaponAnimation == "always" then
            if not weaponAdded then
                GiveWeaponToPed(ped, GetHashKey("weapon_petrolcan"), 0, false, true)
                RemoveWeaponFromPed(ped, GetHashKey("weapon_petrolcan"))
                weaponAdded = true
            end

            if IsPedArmed(ped, 4) then
                SetPedWeaponMovementClipset(ped, "move_ped_wpn_jerrycan_generic", 0.50)
            else
                ResetPedWeaponMovementClipset(ped, 0.0)
            end

        elseif Config.WeaponAnimation == "key" then
            if keyPressed and not weaponAdded then
                GiveWeaponToPed(ped, GetHashKey("weapon_petrolcan"), 0, false, true)
                RemoveWeaponFromPed(ped, GetHashKey("weapon_petrolcan"))
                weaponAdded = true
            end

            if keyPressed then
                if IsPedArmed(ped, 4) then
                    SetPedWeaponMovementClipset(ped, "move_ped_wpn_jerrycan_generic", 0.50)
                else
                    ResetPedWeaponMovementClipset(ped, 0.0)
                end
            else
                ResetPedWeaponMovementClipset(ped, 0.0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Config.WeaponAnimation == "key" then
            if IsControlJustPressed(1, Config.Keybind) then
                keyPressed = not keyPressed
            end
        end
    end
end)
