local busCoords = vector3(456.54, -645.61, 28.49)

Citizen.CreateThread(function()
    while true do
        local playerPed = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(playerPed)
        local dist = #(playerPos - busCoords)

        Citizen.Wait(1)

        if dist < 50 then
            DrawMarker(1, busCoords.x, busCoords.y, busCoords.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)

            if dist < 1.5 then
                if IsControlJustPressed(0, 38) then
                    StartBusJob()
                end
            end
        end
    end
end)

function StartBusJob()
    local spawnPos = vector3(470.35, -584.63, 29.33)
    local vehicle = 'coach'

    if not IsModelInCdimage(vehicle) or not IsModelAVehicle(vehicle) then
        return
    end

    RequestModel(vehicle)

    while not HasModelLoaded(vehicle) do
        Citizen.Wait(0)
    end

    local vehicleHandle = CreateVehicle(vehicle, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, false)
    local playerPed = GetPlayerPed(-1)
    SetPedIntoVehicle(playerPed, vehicleHandle, -1)
    SetModelAsNoLongerNeeded(vehicle)
end
