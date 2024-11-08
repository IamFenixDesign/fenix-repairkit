local QBCore = exports['qb-core']:GetCoreObject()

-- Eliminar el repairkit del inventario
RegisterNetEvent('repairkit:removeItem')
AddEventHandler('repairkit:removeItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.Functions.GetItemByName('repairkit') then
        Player.Functions.RemoveItem('repairkit', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['repairkit'], 'remove')
    end
end)

-- Añadir el item al sistema (qb-inventory y ox_inventory)
QBCore.Functions.CreateUseableItem('repairkit', function(source, item)
    TriggerClientEvent('repairkit:use', source)
end)
