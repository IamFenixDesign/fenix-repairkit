local QBCore = exports['qb-core']:GetCoreObject()

-- Cargar configuración
Config = Config or {}
-- Asegurarse de que el archivo de configuración esté cargado
if not Config then
    print("Error: No se pudo cargar config.lua")
    return
end

-- Función para reparar el vehículo
function RepairVehicle()
    local playerPed = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle() -- Obtiene el vehículo más cercano al jugador

    if vehicle ~= 0 and GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(vehicle), true) < 5.0 then
        local engineHealth = GetVehicleEngineHealth(vehicle)
        
        if engineHealth < Config.MinDamageLevel or (Config.RepairVisualDamage and IsVehicleDamaged(vehicle)) then
            if Config.UseOXLibMinigame then
                local success = lib.skillCheck(Config.OXLibSkillCheck[1], Config.OXLibSkillCheck[2])
                if success then
                    StartRepairProcess(vehicle, playerPed)
                else
                    TriggerEvent('QBCore:Notify', 'Fallaste el minijuego. Reparación fallida.', 'error')
                end
            else
                exports['ps-ui']:Circle(function(success)
                    if success then
                        StartRepairProcess(vehicle, playerPed)
                    else
                        TriggerEvent('QBCore:Notify', 'Fallaste el minijuego. Reparación fallida.', 'error')
                    end
                end, Config.PsUIMiniGameDifficulty.NumberOfCircles, Config.PsUIMiniGameDifficulty.TimeLimit)
            end
        else
            TriggerEvent('QBCore:Notify', 'El vehículo no tiene suficiente daño para ser reparado.', 'error')
        end
    else
        TriggerEvent('QBCore:Notify', 'No hay ningún vehículo cerca para reparar.', 'error')
    end
end

-- Función para iniciar el proceso de reparación
function StartRepairProcess(vehicle, playerPed)
    TaskStartScenarioInPlace(playerPed, Config.RepairAnimation, 0, true)
    QBCore.Functions.Progressbar('repair_vehicle', 'Reparando vehículo...', Config.RepairTime * 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        -- Reparar motor y otros componentes mecánicos
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleFixed(vehicle)

        -- Si está activada la opción para reparar daños visuales
        if Config.RepairVisualDamage then
            SetVehicleDeformationFixed(vehicle)
            SetVehicleBodyHealth(vehicle, 1000.0)
        end

        ClearPedTasksImmediately(playerPed)
        TriggerEvent('QBCore:Notify', 'Vehículo reparado con éxito.', 'success')
        -- Eliminar el ítem del inventario
        TriggerServerEvent('repairkit:removeItem')
    end, function() -- Cancel
        ClearPedTasksImmediately(playerPed)
        TriggerEvent('QBCore:Notify', 'Reparación cancelada.', 'error')
    end)
end

-- Evento para usar el repairkit
RegisterNetEvent('repairkit:use')
AddEventHandler('repairkit:use', function()
    local playerPed = PlayerPedId()

    -- Verificar si el jugador está dentro de un vehículo
    if IsPedInAnyVehicle(playerPed, false) then
        TriggerEvent('QBCore:Notify', 'Debes estar fuera del vehículo para usar el repairkit.', 'error')
        return
    end

    local playerData = QBCore.Functions.GetPlayerData()

    -- Comprobar si se necesita un trabajo específico
    if Config.RequireJob then
        if playerData.job.name == Config.AllowedJob then
            RepairVehicle()
        else
            TriggerEvent('QBCore:Notify', 'No tienes el trabajo adecuado para usar esto.', 'error')
        end
    else
        RepairVehicle()
    end
end)
