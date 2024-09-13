local weaponAdded = false
local keyPressed = false

local function handleWeaponAnimation(ped)
    if not weaponAdded then
        GiveWeaponToPed(ped, GetHashKey("weapon_petrolcan"), 0, false, true)
        RemoveWeaponFromPed(ped, GetHashKey("weapon_petrolcan"))
        weaponAdded = true
    end
end

local function handleMovementClipset(ped)
    if IsPedArmed(ped, 4) then
        SetPedWeaponMovementClipset(ped, "move_ped_wpn_jerrycan_generic", 0.50)
    else
        ResetPedWeaponMovementClipset(ped, 0.0)
    end
end

Citizen.CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Citizen.Wait(100)

        if Config.WeaponAnimation == "always" then
            handleWeaponAnimation(ped)
            handleMovementClipset(ped)

        elseif Config.WeaponAnimation == "key" and keyPressed then
            handleWeaponAnimation(ped)
            handleMovementClipset(ped)
        else
            ResetPedWeaponMovementClipset(ped, 0.0)
        end
    end
end)

-- Thread to handle key press for weapon animation
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
