local isAFK = false
local afkPlayers = {}

-- Events
RegisterNetEvent('afk:PlayerAFK')
AddEventHandler('afk:PlayerAFK', function(id, coord)
    afkPlayers[id] = coords
end)

--Functions--
local function DrawTextNotification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, true)
end

local function checkStillAFK() 
    if isAFK then
        if IsControlJustReleased(0, 32) then 
            isAFK = false 
            DrawTextNotification('You are no longer AFK')
        end
        if IsControlJustReleased(0, 33) then
            isAFK = false 
            DrawTextNotification('You are no longer AFK')
        end
        if IsControlJustReleased(0, 34) then
            isAFK = false 
            DrawTextNotification('You are no longer AFK')
        end
        if IsControlJustReleased(0, 35) then
            isAFK = false 
            DrawTextNotification('You are no longer AFK')
        end
    end
end

-- Draw text in world
local function Draw3DText(msg, coords)
    --local gotCoords, screenX, screenY = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z + 1)

    -- Text formatting
    SetTextColour(255, 255, 255, 215)
    SetTextScale(0.0, 0.3)
    SetTextFont(0)
    SetTextDropShadow(0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(true)
    SetTextProportional(true)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextOutline()

    -- Display the text
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(msg)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

    --DrawText(screenX, screenY)
end

local function displayText(ped)
    local playerPed = PlayerPedId()
    local playerPOS = GetEntityCoords(playerPed)
    local targetPOS = GetEntityCoords(ped)
    local distance = #(playerPOS - targetPOS)
    local hasLOS = HasEntityClearLosToEntity(playerPed, ped, 17)

    if distance <= 20 and hasLOS then
        while isAFK do
            Wait(0)
            local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
            Draw3DText('~g~[AFK]~s~', pos)
            checkStillAFK()
        end
    end
end

local function serverDisplay(target)
    DrawTextNotification('You are now AFK')
    isAFK = true
    local player = GetPlayerFromServerId(target)

    if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)
        displayText(ped)
    end
end

-- Register Event
RegisterNetEvent('afk', serverDisplay)