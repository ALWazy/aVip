ESX, vips = nil, {}

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)


Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT identifier, viplevel FROM users WHERE viplevel > 0", {}, function(result)
        for id, data in pairs(result) do
            vips[data.identifier] = data.viplevel
        end
    end)
end)

RegisterNetEvent("Alwazy:RequestVipLevel")
AddEventHandler("Alwazy:RequestVipLevel", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = GetPlayerIdentifier(_src)
    TriggerClientEvent("Alwazy:callbackVipLvl", _src, (vips[identifier] or 0))
end)