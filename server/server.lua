RegisterNetEvent('prodavnica:opljackana', function (kolicina)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then 
    xPlayer.addAccountMoney('black_money', kolicina)
    end
end)

local lastrob = {}

ESX.RegisterServerCallback('sarmingo-shoprobbery:check', function(source, cb, item)
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier

    if lastrob[identifier] == nil then
        lastrob[identifier] = 0
    end
    
    if (os.time() - lastrob[identifier]) < 1800 and lastrob[identifier] ~= 0 then
        local seconds = 1800 - (os.time() - lastrob[identifier])
        player.showNotification('Wait ' .. ' ' .. math.floor(seconds / 60) .. ' ' .. ' minutes for next robbery')
        cb(false)
    else
        if player.getInventoryItem(item).count >= 1 then
        player.removeInventoryItem(item, 1)
        lastrob[identifier] = os.time()
        cb(true)
    end
    end
end)